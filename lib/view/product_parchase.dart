
import 'package:broadway/view/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/images.dart';
import '../main.dart';

class productparchase extends StatefulWidget {
  const productparchase({super.key});

  @override
  State<productparchase> createState() => _productparchaseState();
}
String? newvalue;
class _productparchaseState extends State<productparchase> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
         appBar: AppBar(
           backgroundColor: Colors.white,
           elevation: 0,
           leading:  InkWell(
             onTap: () {
               Navigator.pop(context);
             },
               child: Container(child: Icon(CupertinoIcons.arrow_left,color: Colors.black,)))
         ),
      body: Padding(
        padding:  EdgeInsets.all(w*0.03),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Review",style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: w*0.08
            ),),
            SizedBox(height: h*0.04),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => payment(),));
              },
              child: Container(
                child: Row(
                  children: [
                    Image.asset(theImages.food),
                    SizedBox(width: w*0.04,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vancho Pastries",style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: w*0.05
                        ),),
                        Text("Fort Kochi, Main road ",style: TextStyle(
                          fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: h*0.04,),
                        Text("6  pcs ")
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: h*0.02),
            Text("Select Payment Method",style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: w*0.04
            ),),
            SizedBox(height: h*0.02),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => payment(),));
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: h*0.08,
                      width: w*0.2,
                      decoration:BoxDecoration(
                          color: thecolors.gray,
                          borderRadius: BorderRadiusDirectional.circular(w*0.01)),
                      child: Image.asset(theImages.paypal),
                    ),
                    SizedBox(width: w*0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Paypal",style: TextStyle(
                          fontWeight: FontWeight.w400,
                            fontSize: w*0.04
                        )),
                        SizedBox(height: h*0.01,),
                        Text("Digital payment platform allowing "),
                        Text("users to link bank accounts, credit "),
                        Text("cards, or debit cards security"),
                      ],
                    ),
                  RadioMenuButton(
                      value: 1,
                      groupValue: "",
                      onChanged: (value) {

                      },
                      child: Text(""))
                  ],
                ),
              ),
            ),
            Divider(
              height: h*0.03,
              color: thecolors.gray,
              thickness: w*0.003,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => payment(),));
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: h*0.08,
                      width: w*0.2,
                      decoration:BoxDecoration(
                          color: thecolors.gray,
                          borderRadius: BorderRadiusDirectional.circular(w*0.01)),
                      child: Image.asset(theImages.card),
                    ),
                    SizedBox(width: w*0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Credit/Debit Cards",style: TextStyle(
                            fontWeight: FontWeight.w400,
                          fontSize: w*0.04
                        )),
                        SizedBox(height: h*0.01,),
                        Text("Visa, Mastercard, American Express etc.",style: TextStyle(
                          fontSize: w*0.0333
                        )),
                      ],
                    ),
                    RadioMenuButton(
                        value: 1,
                        groupValue: "",
                        onChanged: (value) {
                        },
                        child: Text(""))
                  ],
                ),
              ),
            ),
            Divider(
              height: h*0.03,
              color: thecolors.gray,
              thickness: w*0.003,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => payment(),));
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: h*0.08,
                      width: w*0.2,
                      decoration:BoxDecoration(
                          color: thecolors.gray,
                          borderRadius: BorderRadiusDirectional.circular(w*0.01)),
                      child: Image.asset(theImages.broker),
                    ),
                    SizedBox(width: w*0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bank Transfer",style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: w*0.04
                        )),
                        SizedBox(height: h*0.01,),
                        Text("Direct Transfer from the user’s ",),
                        Text("bank account to the "),
                        Text("accommodation providers bank"),
                        Text("account")
                      ],
                    ),
                    SizedBox(width: w*0.04),
                    RadioMenuButton(
                        value: 1,
                        groupValue: "",
                        onChanged: (value) {
                        },
                        child: Text(""))
                  ],
                ),
              ),
            ),
            Divider(
              height: h*0.03,
              color: thecolors.gray,
              thickness: w*0.003,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => payment(),));
              },
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: h*0.08,
                      width: w*0.2,
                      decoration:BoxDecoration(
                          color: thecolors.gray,
                          borderRadius: BorderRadiusDirectional.circular(w*0.01)),
                      child: Image.asset(theImages.wallet),
                    ),
                    SizedBox(width: w*0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Digital Wallets",style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: w*0.04
                        )),
                        SizedBox(height: h*0.01,),
                        Text("Apple APy, Google Pay, and other",),
                        Text("digital wallets for convenien"),
                        Text("secure payments"),
                      ],
                    ),
                    SizedBox(width: w*0.02),
                    RadioMenuButton(
                        value: 1,
                        groupValue: "",
                        onChanged: (value) {
                        },
                        child: Text(""))
                  ],
                ),
              ),
            ),
            Divider(
              height: h*0.03,
              color: thecolors.gray,
              thickness: w*0.003,
            )
          ],
        ),
      ),
    );
  }
}
