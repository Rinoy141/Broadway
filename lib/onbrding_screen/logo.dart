import 'package:broadway/login/registration.dart';
import 'package:flutter/material.dart';

import '../login/loginpage.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Center(child: Text('LOGO')),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Welcome! Simplify your life\n with one app',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 80,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.13,
              color: const Color(0xff004CFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  Registration(),
                    ));
              },
              child: const Text(
                "Let's get started",
                style: TextStyle(
                    color: Color(0xffF3F3F3),
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  ' i already have account',
                  style:  TextStyle(fontSize: 15),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    icon: const Icon(
                      Icons.arrow_circle_right,
                      color: Color(0xff004CFF),
                      size: 35,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
