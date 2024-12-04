import 'dart:convert';
import 'dart:io';
import 'package:broadway/food_app/food_delivery_homepage.dart';
import 'package:broadway/login/app_selection.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import '../login/change_password.dart';
import '../food_app/restaurant_model.dart';
import '../login/loginpage.dart';
import '../profile/edit_profile.dart';

// NotificationSettings model
class NotificationSettings extends ChangeNotifier {
  final Map<String, bool> _settings = {
    'General Notification': true,
    'Sound': false,
    'Vibrate': true,
    'App updates': false,
    'Bill Reminder': true,
    'Promotion': true,
    'Discount Available': false,
    'Payment Request': false,
    'New Service Available': false,
    'New Tips Available': true,
  };

  bool getSetting(String key) => _settings[key] ?? false;

  void toggleSetting(String key) {
    _settings[key] = !(_settings[key] ?? false);
    notifyListeners();
  }
}

/// REGISTRATION
class RegistrationProvider with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String phoneNumber = '';
  bool isLoading = false;
  String? errorMessage;

  Future<void> register(BuildContext context) async {
    if (!validateInputs()) return;

    try {
      setLoading(true);

      final requestBody = {
        'Email': emailController.text.trim(),
        'Phonenumber': phoneNumber.trim(),
        'Username': usernameController.text.trim(),
        'Password': passwordController.text,
      };

      print("Sending registration request: $requestBody");

      final response = await http.post(
        Uri.parse('http://broadway.extramindtech.com/user/createuser/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print("Response received: ${response.statusCode} - ${response.body}");

      if (!context.mounted) return;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['msg'] == 'Rgisteration success') {
          // Clear any previous error messages
          errorMessage = null;
          notifyListeners();

          // Navigate to login page
          await navigateToLogin(context);
          return;
        }
      }

      // Handle error cases
      final responseData = jsonDecode(response.body);
      setError(responseData['msg'] ?? 'Registration failed. Please try again.');
    } catch (e) {
      setError('Connection error. Please check your internet connection.');
      print("Registration error: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> navigateToLogin(BuildContext context) async {
    // Ensure we're not in a loading state before navigation
    setLoading(false);

    if (!context.mounted) return;

    // Navigate immediately without delay
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  bool validateInputs() {
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumber.trim().isEmpty) {
      setError('All fields are required');
      return false;
    }

    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text.trim())) {
      setError('Please enter a valid email address');
      return false;
    }

    return true;
  }

  void updatePhoneNumber(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

///LOGIN

class MainProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late final Dio _dio;
  PersistCookieJar? _cookieJar;
  List<NearbyRestaurant> _nearbyRestaurants = [];
  List<Restaurant> _restaurants = [];
  List<PopularItem> _popularItems = [];
  List<FoodCategory> _foodCategories = [];
  List<dynamic> menuResults = [];
  List<dynamic> restaurantResults = [];
  List<dynamic>? currentSearchResults;
  List<NearbyRestaurant> get nearbyRestaurants => _nearbyRestaurants;
  List<Category> _categories = [];
  List<Category> get categories => _categories;
  List<Restaurant> get restaurants => _restaurants;
  List<PopularItem> get popularItems => _popularItems;
  List<FoodCategory> get foodCategories => _foodCategories;
  Restaurant? _restaurantDetails;
  Restaurant? get restaurantDetails => _restaurantDetails;
  String _error = '';
  int _quantity = 1;
  String get error => _error;
  int get quantity => _quantity;
  String _categoryError = '';
  String get categoryError => _categoryError;
  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  ProfileModel? _userProfile;
  ProfileModel? get userProfile => _userProfile;
  bool _hasSeenOnboarding = false;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  List<OrderHistoryItem> _orderHistory = [];
  List<OrderHistoryItem> get orderHistory => _orderHistory;
  List<OrderHistoryItem> _ongoingOrders = [];
  List<OrderHistoryItem> get ongoingOrders => _ongoingOrders;

  bool _isOrderHistoryLoading = false;
  bool get isOrderHistoryLoading => _isOrderHistoryLoading;

  String _orderHistoryErrorMessage = '';
  String get orderHistoryErrorMessage => _orderHistoryErrorMessage;

  bool _isOngoingOrdersLoading = false;
  bool get isOngoingOrdersLoading => _isOngoingOrdersLoading;

  String _ongoingOrdersErrorMessage = '';
  String get ongoingOrdersErrorMessage => _ongoingOrdersErrorMessage;

  List<RestaurantModel> recommendedRestaurants = [];
  List<RestaurantModel> mostPopularRestaurants = [];
  bool isLoadingRecommended = false;
  bool isLoadingMostPopular = false;

  List<Review> _reviews = [];
  List<Review> get reviews => _reviews;



  MainProvider() {
    _dio = Dio();
    _initializeCookieJar();
    print('LoginProvider initialized');
  }

  Future<void> _initializeCookieJar() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final cookiesDir = '${directory.path}/cookies';

      // Ensure the cookies directory exists
      final dir = Directory(cookiesDir);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      print('Initializing cookie jar at path: $cookiesDir');
      _cookieJar = PersistCookieJar(
          ignoreExpires: true, // Prevent cookie expiration
          storage: FileStorage(cookiesDir));
      _dio.interceptors.add(CookieManager(_cookieJar!));

      // Verify the cookie jar was initialized
      final cookies = await _cookieJar
          ?.loadForRequest(Uri.parse('http://broadway.extramindtech.com'));
      print('Existing cookies after initialization: $cookies');
    } catch (e) {
      print('Error initializing cookie jar: $e');
    }
  }

  Future<void> ensureCookieJarInitialized() async {
    if (_cookieJar == null) {
      await _initializeCookieJar();
    }
  }

  Future<String> getCookieString(Uri url) async {
    try {
      await ensureCookieJarInitialized();
      final cookies = await _cookieJar?.loadForRequest(url);
      final cookieString = cookies
              ?.map((cookie) => '${cookie.name}=${cookie.value}')
              .join('; ') ??
          '';
      print('Generated Cookie String: $cookieString');
      return cookieString;
    } catch (e) {
      print('Error generating cookie string: $e');
      return '';
    }
  }

  Future<void> loadOnboardingState() async {
    if (_cookieJar == null) {
      print('CookieJar is null during loadOnboardingState');
      return;
    }

    try {
      final cookies = await _cookieJar!.loadForRequest(Uri.parse('app://onboarding'));
      print('Loaded cookies: $cookies');

      final onboardingCookie = cookies.firstWhere(
            (cookie) => cookie.name == 'onboarding_state',
        orElse: () => Cookie('onboarding_state', 'false'),
      );

      print('Onboarding cookie value: ${onboardingCookie.value}');
      _hasSeenOnboarding = onboardingCookie.value == 'true';

      print('Has seen onboarding: $_hasSeenOnboarding');
    } catch (e) {
      print('Error loading onboarding state: $e');
      _hasSeenOnboarding = false;
    }
    notifyListeners();
  }

  Future<void> setOnboardingComplete() async {
    if (_cookieJar == null) {
      print('CookieJar is null during setOnboardingComplete');
      return;
    }

    final onboardingCookie = Cookie('onboarding_state', 'true')
      ..path = '/'
      ..maxAge = 31536000; // 1 year in seconds

    await _cookieJar!.saveFromResponse(Uri.parse('app://onboarding'), [onboardingCookie]);
    _hasSeenOnboarding = true;
    print('Onboarding set to complete. Saved cookie.');
    notifyListeners();
  }



  /// Basic login authentication
  Future<bool> login(BuildContext context) async {
    await ensureCookieJarInitialized();
    print('Login process started');

    const url = 'http://broadway.extramindtech.com/user/login/';
    final body = {
      'Email': emailController.text,
      'Password': passwordController.text,
    };

    try {
      // Log the existing cookies before login
      final preCookies = await getCookieString(Uri.parse(url));
      print('Cookies before login: $preCookies');

      final response = await _dio.post(
        url,
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': preCookies,
          },
          validateStatus: (status) =>
              true, // Allow all status codes for debugging
        ),
      );

      print('Login response status: ${response.statusCode}');
      print('Login response data: ${response.data}');

      // Log the cookies after login
      final postCookies = await getCookieString(Uri.parse(url));
      print('Cookies after login: $postCookies');

      if (response.statusCode == 200 &&
          response.data['msg'] == 'Login Success') {
        print('Login successful');

        // Verify cookies were saved
        final savedCookies = await _cookieJar?.loadForRequest(Uri.parse(url));
        print('Saved cookies after login: $savedCookies');

        return true;
      } else {
        final errorMsg = response.data['msg'] ??
            'An error occurred. Please try again later.';
        _showErrorDialog(context, errorMsg);
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      _showErrorDialog(context, 'An error occurred. Please try again later.');
      return false;
    }
  }




  /// Main login handler with navigation logic
  Future<void> handleLogin(BuildContext context) async {
    if (!context.mounted) return;

    _isLoading = true;
    notifyListeners();

    try {
      final loginSuccess = await login(context);
      print('Login success: $loginSuccess');

      if (loginSuccess) {
        // Check if profile is set
        final hasProfile = await isProfileSet();
        print('Has profile: $hasProfile');

        if (!context.mounted) return;

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful')),
        );

        if (hasProfile) {
          print('Profile exists, navigating to App selection Page');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AppSelection()),
          );
        } else {
          print('Profile not set, navigating to EditProfilePage');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
        }
      }
    } catch (e) {
      print('Error in handleLogin: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Failed')),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///change password
  Future<bool> changePassword(BuildContext context) async {
    await ensureCookieJarInitialized();


    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    const url = 'http://broadway.extramindtech.com/user/changepassword/';
    final body = {
      'Password': newPasswordController.text,
    };

    try {

      final preCookies = await getCookieString(Uri.parse(url));
      print('Cookies before change password: $preCookies');

      final response = await _dio.put(
        url,
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': preCookies,
          },
          validateStatus: (status) => true,
        ),
      );

      print('Change Password response status: ${response.statusCode}');
      print('Change Password response data: ${response.data}');

      if (response.statusCode == 200 && response.data['msg'] == 'Password changed successfully') {
        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  LoginPage())
        );
        return true;

      } else {

        final errorMsg = response.data['msg'] ?? 'Failed to change password';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      print('Error during password change: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  /// Add or Update User Address

  Future<bool> addOrUpdateAddress({
    required String country,
    required String address,
    required String district,
    required String place,
    required String gender,
  }) async
  {await ensureCookieJarInitialized();

  const url = 'http://broadway.extramindtech.com/user/addaddress/';
  final body = {
    'Country': country,
    'Address': address,
    'District': district,
    'Place': place,
    'Gender': gender,
  };

  print('Request Body for Add/Update Address: $body');

  try {
    final cookieString = await getCookieString(Uri.parse(url));
    print('Cookies for address update: $cookieString');

    final response = await _dio.post(
      url,
      data: jsonEncode(body),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookieString,
        },
      ),
    );

    print('Add/Update Address response status: ${response.statusCode}');
    print('Add/Update Address response data: ${response.data}');

    if (response.statusCode == 200 &&
        (response.data['msg'] == 'Data saved Successfully' ||
            response.data['msg']
                ?.toString()
                .toLowerCase()
                .contains('success') ==
                true)) {
      print('Successfully added/updated address: ${response.data['msg']}');
      return true;
    } else {
      print('Failed to add/update address: ${response.data['msg']}');
      return false;
    }
  } catch (e) {
    print('Error during add/update address: $e');
    return false;
  }
  }

  /// Check if user profile is set
  Future<bool> isProfileSet() async {
    await ensureCookieJarInitialized();

    try {
      const url = 'http://broadway.extramindtech.com/user/profile_view/';

      // Log cookies before making the request
      final cookieString = await getCookieString(Uri.parse(url));
      print('Cookies before profile check: $cookieString');

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
          validateStatus: (status) =>
          true, // Allow all status codes for debugging
        ),
      );

      print('Profile check response status: ${response.statusCode}');
      print('Profile check response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final profileData = response.data;
        if (profileData is Map) {
          final hasProfile = profileData['Address'] != null &&
              profileData['District'] != null &&
              profileData['Place'] != null &&
              profileData['Address'].toString().isNotEmpty &&
              profileData['District'].toString().isNotEmpty &&
              profileData['Place'].toString().isNotEmpty;

          print('Profile check result: hasProfile=$hasProfile');
          print('Profile data: $profileData');
          return hasProfile;
        }
      }
      print('Profile check failed: Invalid response format or status code');
      return false;
    } catch (e) {
      print('Error checking profile status: $e');
      return false;
    }
  }

  ///view profile
  Future<ProfileModel?> fetchUserProfile() async {
    try {
      await ensureCookieJarInitialized();

      const url = 'http://broadway.extramindtech.com/user/profile_view/';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
          validateStatus: (status) => true,
        ),
      );

      print('Profile view response status: ${response.statusCode}');
      print('Profile view response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        _userProfile = ProfileModel.fromJson(response.data);
        notifyListeners();
        return _userProfile;
      } else {
        print('Failed to fetch profile: ${response.data}');
        _userProfile = null;
        notifyListeners();
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      _userProfile = null;
      notifyListeners();
      return null;
    }
  }


  /// Handle profile update and navigation
  Future<void> handleAddressUpdate({
    required BuildContext context,
    required String country,
    required String address,
    required String district,
    required String place,
    required String gender,
  }) async
  {
    if (!context.mounted) return;

    _isLoading = true;
    notifyListeners();

    try {
      final success = await addOrUpdateAddress(
        country: country,
        address: address,
        district: district,
        place: place,
        gender: gender,
      );

      if (!context.mounted) return;

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        // Navigate to BestPartnersPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AppSelection()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  ///Add to cart

  Future<bool> addToCart(int itemId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final url =
          Uri.parse('http://broadway.extramindtech.com/food/addcart/$itemId');
      final cookieString = await getCookieString(url);

      final response = await _dio.post(
        url.toString(),
        data: {"Quantity": _quantity},
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      _isLoading = false;

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['msg'] == 'Cart Added Successfully') {
          notifyListeners();
          return true;
        }
      }

      _error = 'Failed to add to cart';
      notifyListeners();
      return false;
    } catch (e) {
      print('Error adding to cart: $e');
      _isLoading = false;
      _error = 'Error adding to cart';
      notifyListeners();
      return false;
    }
  }
  Future<void> fetchCartItems() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final url = 'http://broadway.extramindtech.com/food/viewcart/';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final totalPriceValue = responseData['Total Price'];

        _cartItems = (responseData['Items'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();

        _totalPrice = totalPriceValue is num
            ? totalPriceValue.toDouble()
            : double.tryParse(totalPriceValue.toString()) ?? 0.0;
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      _error = 'Error fetching cart items: ${e.toString()}';
      _cartItems = [];
      _totalPrice = 0.0;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeCartItem(int cartItemId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = 'http://broadway.extramindtech.com/food/deletecart/$cartItemId';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Remove the item from the list
        _cartItems.removeWhere((item) => item.id == cartItemId);

        // Recalculate total price
        _totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));

        notifyListeners();
      } else {
        throw Exception('Failed to remove cart item');
      }
    } catch (e) {
      _error = 'Error removing cart item: ${e.toString()}';
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
    }
  }
  Future<void> updateCartItemQuantity(int cartItemId, int newQuantity) async {
    try {
      final url = 'http://broadway.extramindtech.com/food/cartupdate/$cartItemId';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.put(
        url,
        data: {"Quantity": newQuantity},
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {

        final updatedItemIndex = _cartItems.indexWhere((item) => item.id == cartItemId);
        if (updatedItemIndex != -1) {
          _cartItems[updatedItemIndex].quantity = newQuantity;


          _totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));

          notifyListeners();
        }
      } else {
        throw Exception('Failed to update cart item quantity');
      }
    } catch (e) {
      print('Error in updateCartItemQuantity(): $e');
      throw e;
    }
  }


  void updateQuantity(int change) {
    if (_quantity + change >= 1) {
      _quantity = _quantity + change;
      notifyListeners();
    }
  }

  void resetQuantity() {
    _quantity = 1;
    notifyListeners();
  }

  ///apply code
  Future<void> applyPromoCode(BuildContext context, String code) async {
    await ensureCookieJarInitialized();

    const url = 'http://broadway.extramindtech.com/food/promocode/';
    final body = {'Code': code};

    try {
      final cookieString = await getCookieString(Uri.parse(url));
      final response = await _dio.post(
        url,
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
          validateStatus: (status) => true, // Accept all responses for debugging
        ),
      );

      print('Promo Code response status: ${response.statusCode}');
      print('Promo Code response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final message = response.data['msg'] ?? 'Promo code applied successfully.';
        final newTotal = response.data['totalPrice'];
        if (newTotal != null) {
          _totalPrice = newTotal;
          notifyListeners();
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } else {
        final errorMsg = response.data['msg'] ?? 'Failed to apply promo code.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } catch (e) {
      print('Error applying promo code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }
  ///add order
  Future<bool> placeOrder(BuildContext context, String selectedPaymentMethod) async {
    try {
      await ensureCookieJarInitialized();

      const url = 'http://broadway.extramindtech.com/food/addorders/';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.post(
        url,
        data: {
          "payment_method": selectedPaymentMethod

        },


        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },

        ),
      );
      print('Place Order response status: ${response.statusCode}');
      print('Place Order response data: ${response.data}');
      print('Order type: $selectedPaymentMethod');

      if (response.statusCode == 200) {

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Order Placed Successfully')),
            );
          }
          return true;

      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      print('Error placing order: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to place order: ${e.toString()}')),
        );
      }
      return false;
    }
  }
/// show order history
  Future<void> fetchOrderHistory() async {
    await ensureCookieJarInitialized();

    _isOrderHistoryLoading = true;
    _orderHistoryErrorMessage = '';
    notifyListeners();

    try {
      const url = 'http://broadway.extramindtech.com/food/orderhistory/';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        _orderHistory = responseData
            .map((item) => OrderHistoryItem.fromJson(item))
            .toList();
        _isOrderHistoryLoading = false;
        notifyListeners();
      } else {
        _orderHistoryErrorMessage = 'Failed to load order history';
        _isOrderHistoryLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _orderHistoryErrorMessage = 'An error occurred: ${e.toString()}';
      _isOrderHistoryLoading = false;
      notifyListeners();
    }
  }
  ///show ongoing order
  Future<void> fetchOngoingOrders() async {
    await ensureCookieJarInitialized();

    _isOngoingOrdersLoading = true;
    _ongoingOrdersErrorMessage = '';
    notifyListeners();

    try {
      const url = 'http://broadway.extramindtech.com/food/ongoingorders/';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
        ),
      );

      if (response.statusCode == 200) {

        if (response.data is List) {
          final List<dynamic> responseData = response.data;
          _ongoingOrders = responseData
              .map((item) => OrderHistoryItem.fromJson(item))
              .toList();
        } else if (response.data is Map &&
            response.data['msg'] == 'No item ongoing') {

          _ongoingOrders = [];
        } else {

          _ongoingOrders = [];
          _ongoingOrdersErrorMessage = 'Unexpected response format';
        }

        _isOngoingOrdersLoading = false;
        notifyListeners();
      } else {
        _ongoingOrdersErrorMessage = 'Failed to load ongoing orders';
        _isOngoingOrdersLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _ongoingOrdersErrorMessage = 'An error occurred: ${e.toString()}';
      _isOngoingOrdersLoading = false;
      notifyListeners();
    }
  }
  ///cancel order
  Future<bool> cancelOrder(BuildContext context, int orderId) async {
    await ensureCookieJarInitialized();

    final url = 'http://broadway.extramindtech.com/food/cancelorder/$orderId';

    try {
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
          validateStatus: (status) => true,
        ),
      );

      print('Cancel Order response status: ${response.statusCode}');
      print('Cancel Order response data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data['msg'] == 'Order cancelled successfully') {



        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order cancelled successfully'),
            backgroundColor: Colors.green,
          ),
        );

        return true;
      } else {
        final errorMsg = response.data['msg'] ?? 'Failed to cancel order';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          ),
        );

        return false;
      }
    } catch (e) {
      print('Error during order cancellation: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );

      return false;
    }
  }


  /// Perform search query
  Future<void> searchMenuAndRestaurants(String query) async {
    try {
      if (query.isEmpty) {
        currentSearchResults = []; // Clear results for empty query
        menuResults = [];
        restaurantResults = [];
        notifyListeners();
        return;
      }

      final searchResults = await fetchSearchResults(query);

      // Separate menu items and restaurants
      menuResults = searchResults['menu_items'] ?? [];
      restaurantResults = searchResults['restaurants'] ?? [];

      // Combine for overall search results display
      currentSearchResults = [...menuResults, ...restaurantResults];

      notifyListeners();
    } catch (e) {
      print('Error while searching: $e');
      throw Exception('Failed to fetch search results');
    }
  }

  Future<Map<String, dynamic>> fetchSearchResults(String query) async {
    const String baseUrl =
        'http://broadway.extramindtech.com/food/getbysearch/';

    try {
      final url = Uri.parse(baseUrl);

      final cookieString = await getCookieString(url);

      final response = await _dio.post(
        url.toString(),
        data: jsonEncode({"Search": query}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      print('Search response status: ${response.statusCode}');
      print('Search response data: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'menu_items': response.data['menu_items'] ?? [],
          'restaurants': response.data['restaurants'] ?? []
        };
      } else {
        throw Exception('Failed to search menu and restaurants');
      }
    } catch (e) {
      print('Error fetching search results: $e');
      throw Exception('Failed to fetch search results');
    }
  }

  ///category
  Future<void> fetchCategories() async {
    try {
      _isLoadingCategories = true;
      _categoryError = '';
      notifyListeners();

      await ensureCookieJarInitialized();
      final url =
          Uri.parse('http://broadway.extramindtech.com/food/categories/');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }

        final List<dynamic> categoriesJson = response.data;
        _categories =
            categoriesJson.map((json) => Category.fromJson(json)).toList();
        _categoryError = '';
      } else {
        throw Exception(
            'Failed to fetch categories. Status: ${response.statusCode}');
      }
    } catch (e) {
      _categoryError = 'Failed to load categories: $e';
      _categories = [];
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  ///with category id
  Future<List<MenuItem>> getMenuItemsByCategory(int categoryId) async {
    try {
      final response = await _dio.get(
        'http://broadway.extramindtech.com/food/categories/$categoryId',
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((item) => MenuItem.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch menu items: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// reviews
  Future<void> fetchReviews(int restaurantId) async {
    try {
      await ensureCookieJarInitialized();

      final url = 'http://broadway.extramindtech.com/food/getreviews/$restaurantId';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {

        _reviews = (response.data as List).map((json) => Review.fromJson(json)).toList();
        _error = '';
      } else {
        _error = 'Failed to fetch reviews: ${response.data}';
        _reviews = [];
      }

      notifyListeners();
    } catch (e) {
      _error = 'Error fetching reviews: $e';
      _reviews = [];
      notifyListeners();
    }
  }
  ///fetch restaurants with id
  Future<void> fetchRestaurantDetails(int restaurantId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(
          'http://broadway.extramindtech.com/food/restaurants/$restaurantId');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> restaurantDetailsJson = response.data;
        if (restaurantDetailsJson.isNotEmpty) {
          _restaurantDetails = Restaurant.fromJson(restaurantDetailsJson[0]);
          _isLoading = false;
          notifyListeners();
        } else {
          throw Exception('No restaurant details found');
        }
      } else {
        throw Exception('Failed to fetch restaurant details');
      }
    } catch (e) {
      print('Error fetching restaurant details: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
  ///add review
  Future<bool> addRestaurantReview({
    required BuildContext context,
    required int restaurantId,
    required int rating,
    String review = ''
  })
  async {
    try {
      await ensureCookieJarInitialized();

      final url = 'http://broadway.extramindtech.com/food/addreviews/$restaurantId';
      final cookieString = await getCookieString(Uri.parse(url));

      final response = await _dio.post(
        url,
        data: {
          "Review": review.isNotEmpty ? review : 'Rating submitted',
          "Rating": rating
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
          },
          validateStatus: (status) => true,
        ),
      );

      print('Add Review Response: ${response.data}');
      print('Add Review Status Code: ${response.statusCode}');

      if (response.statusCode == 200 &&
          response.data['msg'] == 'Review submitted successfully') {

        await fetchReviews(restaurantId);

        return true;
      } else {

        final errorMsg = response.data['msg'] ?? 'Failed to submit review';
        _showErrorDialog(context, errorMsg);
        return false;
      }
    } catch (e) {
      print('Error adding restaurant review: $e');
      _showErrorDialog(context, 'An error occurred while submitting review');
      return false;
    }
  }



  /// Fetch Restaurants

  Future<List<Restaurant>> fetchRestaurants(BuildContext context) async {
    try {
      await ensureCookieJarInitialized();

      final url =
          Uri.parse('http://broadway.extramindtech.com/food/restaurants/');
      final cookieString = await getCookieString(url);

      print('Fetching restaurants...');
      print('Request URL: $url');
      print('Request Cookies: $cookieString');

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      print('Restaurants response status: ${response.statusCode}');
      print('Restaurants response data: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> restaurantsJson = response.data;
        return restaurantsJson
            .map((json) => Restaurant.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch restaurants');
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
      throw Exception('Failed to fetch restaurants');
    }
  }

  /// Best rest
  Future<List<BestSeller>> fetchBestSellers(BuildContext context) async {
    try {
      await ensureCookieJarInitialized();

      final url =
          Uri.parse('http://broadway.extramindtech.com/food/bestsellers/');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> bestSellersJson = data['Best sellers'];
        return bestSellersJson
            .map((json) => BestSeller.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch best sellers');
      }
    } catch (e) {
      print('Error fetching best sellers: $e');
      throw Exception('Failed to fetch best sellers');
    }
  }

  /// Fetch Restaurant Menu

  Future<void> fetchRestaurantMenu(int restaurantId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(
          'http://broadway.extramindtech.com/food/restaurantmenu/$restaurantId');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final menuData = response.data;

        final popularItemsJson = menuData['popularItems'] as List<dynamic>;
        _popularItems =
            popularItemsJson.map((json) => PopularItem.fromJson(json)).toList();

        final categoriesJson = menuData['foodCategories'] as List<dynamic>;
        _foodCategories =
            categoriesJson.map((json) => FoodCategory.fromJson(json)).toList();

        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to fetch restaurant menu');
      }
    } catch (e) {
      print('Error fetching restaurant menu: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  ///fetch by price
  Future<List<Restaurant>> fetchMenuByPrice(int minPrice, int maxPrice) async {
    try {
      await ensureCookieJarInitialized();

      final url =
          Uri.parse('http://broadway.extramindtech.com/food/getbyprice/');
      final cookieString = await getCookieString(url);

      final response = await _dio.post(
        url.toString(),
        data: jsonEncode({'Price': maxPrice}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> priceRangeFoodsJson = response.data;
        return priceRangeFoodsJson
            .map((json) => Restaurant.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch menu items by price');
      }
    } catch (e) {
      print('Error fetching menu by price: $e');
      rethrow;
    }
  }

  ///nearby
  Future<void> fetchNearbyRestaurants() async {
    try {
      _isLoading = true;
      notifyListeners();

      final url =
          Uri.parse('http://broadway.extramindtech.com/food/nearbysearch/');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Directly parse the response data as a list when it starts with [ ]
        final List<dynamic> nearbyRestaurantsJson = response.data;

        _nearbyRestaurants = nearbyRestaurantsJson
            .map((json) => NearbyRestaurant.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch nearby restaurants');
      }
    } catch (e) {
      print('Error fetching nearby restaurants: $e');
      _nearbyRestaurants = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  ///recommended
  Future<void> fetchRecommendedRestaurants() async {
    try {
      isLoadingRecommended = true;
      notifyListeners();

      final url = Uri.parse('http://broadway.extramindtech.com/food/recommended/');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Check if response.data is a Map and contains 'Recommended Items'
        final List<dynamic> recommendedRestaurantsJson =
        response.data is Map
            ? (response.data['Recommended Items'] ?? [])
            : response.data ?? [];

        recommendedRestaurants = recommendedRestaurantsJson
            .map((json) => RestaurantModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch recommended restaurants');
      }
    } catch (e) {
      print('Error fetching recommended restaurants: $e');
      recommendedRestaurants = [];
    } finally {
      isLoadingRecommended = false;
      notifyListeners();
    }
  }
  ///popular
  Future<void> fetchMostPopularRestaurants() async {
    try {
      isLoadingMostPopular = true;
      notifyListeners();

      final url = Uri.parse('http://broadway.extramindtech.com/food/mostpopular/');
      final cookieString = await getCookieString(url);

      final response = await _dio.get(
        url.toString(),
        options: Options(
          headers: {
            'Cookie': cookieString,
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Check if response.data is a Map and contains 'Most Popular Items'
        final List<dynamic> mostPopularRestaurantsJson =
        response.data is Map
            ? (response.data['Most Popular Items'] ?? [])
            : response.data ?? [];

        mostPopularRestaurants = mostPopularRestaurantsJson
            .map((json) => RestaurantModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch most popular restaurants');
      }
    } catch (e) {
      print('Error fetching most popular restaurants: $e');
      mostPopularRestaurants = [];
    } finally {
      isLoadingMostPopular = false;
      notifyListeners();
    }
  }
  /// reviews






  /// Logout method
  Future<void> logout() async {
    await ensureCookieJarInitialized();
    print('Logging out...');
    await _cookieJar?.deleteAll();
    emailController.clear();
    passwordController.clear();
    notifyListeners();
    print('Logged out and cookies cleared');
  }

  /// Show error dialog with a custom message
  void _showErrorDialog(BuildContext context, String message) {
    print('Showing error dialog: $message');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

///FORGOT PASSWORD


class ForgotPasswordProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  bool isOTPSent = false;

  Future<bool> forgotPassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://broadway.extramindtech.com/user/sendotpemail/');
    final body = {
      'Email': emailController.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.headers['content-type']?.contains('application/json') == true) {
        final data = jsonDecode(response.body);
        print('Forgot password API response: $data');

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP sent successfully to your email'),
              backgroundColor: Colors.green,
            ),
          );
          isOTPSent = true;
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send OTP. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected response from server'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      print('Exception occurred during password reset: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> verifyOTP(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://broadway.extramindtech.com/user/verifyotp/');
    final body = {
      'Otp': otpController.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.headers['content-type']?.contains('application/json') == true) {
        final data = jsonDecode(response.body);
        print('OTP Verification API response: $data');

        if (response.statusCode == 200 ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP verified successfully'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to Change Password Screen
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChangePasswordScreen())
          );

          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message'] ?? 'Invalid OTP'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected server response'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      print('Exception occurred during OTP verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
