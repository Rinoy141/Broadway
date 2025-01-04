
import 'package:flutter/material.dart';


import '../common/colors.dart';
import '../common/images.dart';
import '../main.dart';
import '../view/buy_one.dart';
// import 'buy_one.dart';
class orderconfirmation extends StatefulWidget {
  const orderconfirmation({super.key});

  @override
  State<orderconfirmation> createState() => _orderconfirmationState();
}

class _orderconfirmationState extends State<orderconfirmation> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: thecolors.primaryColor,
      appBar: AppBar(
        backgroundColor: thecolors.primaryColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //   child: Container(
          //       child: Lottie.asset(theImages.lottie)),
          // ),
          Center(
            child: CircleAvatar(
              radius: w*0.3,
              backgroundColor:thecolors.skyblue3,
              child: Image.asset(theImages.tick),
            ),
          ),
          SizedBox(height: h*0.03,),
          Text("Congratulations",style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: w*0.07,
              color: thecolors.skyblue3
          )),
          SizedBox(height: h*0.03,),
          Text("Your Payment Is Successfully",style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: w*0.05
          )),
          SizedBox(height: h*0.3),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BuyOne(),));
            },
            child: Container(
              height: h*0.06,
              width: w*0.4,
              decoration: BoxDecoration(
                color: thecolors.blow2,
                borderRadius: BorderRadiusDirectional.circular(w*0.03),
              ),
              child: Center(
                child: Text('Back to home',style: TextStyle(
                    color: thecolors.primaryColor
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
