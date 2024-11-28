import 'package:broadway/login/registration.dart';
import 'package:broadway/onbrding_screen/logo.dart';
import 'package:broadway/onbrding_screen/onbrding_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/loginpage.dart';
import '../providerss/app_provider.dart';
import 'onbrding_model.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OnboardingState(),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          blurRadius: 20,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: PageView.builder(
                    onPageChanged: (value) {

                        Provider.of<OnboardingState>(context, listen: false).updateCurrentIndex(value);

                    },
                    itemCount: onbrdingModelList.length,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Image(
                              image: AssetImage(onbrdingModelList[index].img),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(onbrdingModelList[index].text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18)),
                          if (onbrdingModelList[index].buttonText != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: MaterialButton(
                                color: const Color(0xff004CFF),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  Provider.of<MainProvider>(context, listen: false)
                                      .setOnboardingComplete();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  LogoPage()),
                                  );
                                },
                                child: Text(
                                  onbrdingModelList[index].buttonText!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SmoothPageIndicator(
                    controller: pageController,
                    effect: const JumpingDotEffect(),
                    count: onbrdingModelList.length),
              ],
            ),
          ),
        ));
  }
}
