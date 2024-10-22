
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

import 'order_confirmation.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton:InkWell(
        onTap:() {
          Navigator.push(context,MaterialPageRoute(builder: (context) => orderconfirmation(),));
        },
        child: Container(
          height: h*0.09,
          width: w*0.9,
          decoration: BoxDecoration(
            borderRadius:BorderRadiusDirectional.circular(w*0.06),
            color: thecolors.blow,
          ),
          child: Center(child: Text("Confirm",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: w*0.06
          ),)),
        ),
      ),
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
        padding:  EdgeInsets.all(w*0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: h*0.01),
              Text("Payment",style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: h*0.05
              ),),
              SizedBox(height: h*0.01,),
              Container(
                // color: thecolors.gray3,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    fillColor:thecolors.gray3,
                      filled: true,
                      hintText: "IFSC Code",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.06),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01,),
              Container(
                // color: thecolors.gray3,
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "Holder’s Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.06),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01,),
              Container(
                // color: thecolors.gray3,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                      fillColor:thecolors.gray3,
                      hintText: "Bank account number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.06),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01,),
              Container(
                // color: thecolors.gray3,
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "Re-enter bank account numbe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.06),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
