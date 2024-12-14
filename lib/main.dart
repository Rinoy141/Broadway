import 'package:broadway/common/sharedpref/shared_pref.dart';
import 'package:broadway/food_app/state%20providers/payment_provider.dart';
import 'package:broadway/food_app/state%20providers/profile_provider.dart';
import 'package:broadway/food_app/state%20providers/rating_provider.dart';
import 'package:broadway/login/app_selection.dart';
import 'package:broadway/onbrding_screen/onbrding_provider.dart';
import 'package:broadway/onbrding_screen/onbrding_screen.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final userId = await SharedPreferencesHelper.getUserId();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainProvider()),
      ChangeNotifierProvider(create: (context) => ProfileViewProvider()),
      ChangeNotifierProvider(create: (context) => PaymentMethodProvider()),
      ChangeNotifierProvider(create: (context) => RatingProvider()),


    ],
    child:  MyApp(userId: userId,),
  )
  );
}

class MyApp extends StatelessWidget {
  final String? userId;
   const MyApp({super.key, this.userId});


  @override
  Widget build(BuildContext context) {

    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        //print('Building MyApp with hasSeenOnboarding: ${mainProvider.hasSeenOnboarding}');
        return MaterialApp(
            debugShowCheckedModeBanner: false, 
            // home:
            //  mainProvider.hasSeenOnboarding ?  LoginPage() :  OnboardingScreen()
            home: userId != null ? AppSelection(userId: userId!,) : OnboardingScreen(),
            //home: mainProvider.isLoading ? AppSelection() : mainProvider.hasSeenOnboarding ? LoginPage() : OnboardingScreen(),
             );

      },
    );
  }
}
