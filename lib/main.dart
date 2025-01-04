import 'package:broadway/common/sharedpref/shared_pref.dart';
import 'package:broadway/login/app_selection.dart';
import 'package:broadway/onbrding_screen/onbrding_provider.dart';
import 'package:broadway/onbrding_screen/onbrding_screen.dart';
import 'package:broadway/providerss/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Buy_and sell/buy_1.dart';
import 'Buy_and sell/buy_one.dart';
var w;
var h;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final userId = await SharedPreferencesHelper.getUserId();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainProvider()),
      //ChangeNotifierProvider(create: (context) => NotificationSettings()),
      //ChangeNotifierProvider(create: (_) => MainProvider()..loadOnboardingState()),

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
    h=MediaQuery.of(context).size.height;
    w=MediaQuery.of(context).size.width;
    return Consumer<MainProvider>(builder: (context, mainProvider, child) {
        //print('Building MyApp with hasSeenOnboarding: ${mainProvider.hasSeenOnboarding}');
        return MaterialApp(
            debugShowCheckedModeBanner: false, 
            // home:
            //  mainProvider.hasSeenOnboarding ?  LoginPage() :  OnboardingScreen()
            home: userId != null ? AppSelection(userId: userId!,) : BuyOne(),
            //home: mainProvider.isLoading ? AppSelection() : mainProvider.hasSeenOnboarding ? LoginPage() : OnboardingScreen(),
             );

      },
    );
  }
}
