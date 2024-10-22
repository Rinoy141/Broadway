import 'package:broadway/food_app/food_delivery_homepage.dart';
import 'package:broadway/food_app/food_details_page.dart';
import 'package:broadway/food_app/order_history page.dart';
import 'package:broadway/food_app/rating/driver_rating.dart';
import 'package:broadway/food_app/search_br.dart';
import 'package:broadway/hospital_app/hospital.dart';


import 'package:broadway/login/app_selection.dart';

import 'package:broadway/login/loginpage.dart';
import 'package:broadway/onbrding_screen/logo.dart';
import 'package:broadway/onbrding_screen/onbrding_provider.dart';
import 'package:broadway/onbrding_screen/onbrding_screen.dart';
import 'package:broadway/login/registration.dart';
import 'package:broadway/profile/profile.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:broadway/view/buy_one.dart';
import 'package:broadway/view/enqueries%20recieved.dart';
import 'package:broadway/view/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hospital_app/history_page.dart';
import 'hospital_app/provider.dart';
import 'login/password_rec_provider.dart';
import 'food_app/food_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OnboardingState()),
      ChangeNotifierProvider(create: (context) => RestaurantProvider()),
      ChangeNotifierProvider(create: (context) => RatingProvider()),
      ChangeNotifierProvider(create: (context) => PasswordRecoveryProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => NotificationSettings()),
    ],
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: MedicalApp());
  }
}
