
import 'package:broadway/login/loginpage.dart';
import 'package:broadway/onbrding_screen/onbrding_provider.dart';
import 'package:broadway/onbrding_screen/onbrding_screen.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'food_app/food_provider.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => OnboardingState()),
      ChangeNotifierProvider(create: (context) => RatingProvider()),
      ChangeNotifierProvider(create: (context) => NotificationSettings()),
      ChangeNotifierProvider(create: (_) => MainProvider()..loadOnboardingState()),

    ],
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return Consumer<MainProvider>(
      builder: (context, mainProvider, child) {
        print('Building MyApp with hasSeenOnboarding: ${mainProvider.hasSeenOnboarding}');
        return MaterialApp(
            debugShowCheckedModeBanner: false, home:  mainProvider.hasSeenOnboarding
            ?  LoginPage() // Replace with your main screen
            :  OnboardingScreen());

      },

    );
  }
}
