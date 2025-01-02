import 'package:broadway/common/colors.dart';
import 'package:broadway/common/images.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class applicentprofile extends StatefulWidget {
  const applicentprofile({super.key});

  @override
  State<applicentprofile> createState() => _applicentprofileState();
}

class _applicentprofileState extends State<applicentprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_rounded),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: h*0.2,
              width: w*0.2,
              child: CircleAvatar(
                  backgroundImage:AssetImage(theImages.applicatation,)
              ),
            ),
          ),
          Container(
            height: h*0.3,
            width: w*0.8,
            decoration: BoxDecoration(
                color: thecolors.gray,
                borderRadius: BorderRadiusDirectional.circular(w*0.03)
            ),
            child: Column(
              children: [
                SizedBox(height: h*0.05,),
                Text('Kate Norman',style: TextStyle(
                    fontSize: w*0.05,
                    fontWeight: FontWeight.w800
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Designer'),
                    Text('UX Researcher')
                  ],
                ),
                SizedBox(height: h*0.04,),
                Text('Qualification'),
                Text('BCA',style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: w*0.05
                ),),
                SizedBox(height: h*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('email '),
                        Text('axdhx@gmail.com')
                      ],
                    ),
                    Column(
                      children: [
                        Text('mobile number'),
                        Text('123333339')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: h*0.01,),
          Container(
            height: h*0.3,
            width: w*0.8,
            decoration: BoxDecoration(
                color: thecolors.gray,
                borderRadius: BorderRadiusDirectional.circular(w*0.03)
            ),
            child: Column(
              children: [
                Text('Description',style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),),
                SizedBox(height: h*0.02,),
                Text('As a UX designer, I specialize in crafting seamless user ',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('experiences that align with your brand and resonate with',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('your audience. My services encompass comprehensive ',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('user research, wireframing, prototyping, and interface  ',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('design. I focus on understanding user behaviors, pain   ',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('points, and preferences to create intuitive and engaging',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('digital products. Whether its improving existing ',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('nterfaces or creating new ones from scratch, I ensure',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('designs that are user-centric, visually appealing, and ',style: TextStyle(
                    fontSize: w*0.03
                ),),
                Text('optimized for usability across devices and platforms',style: TextStyle(
                    fontSize: w*0.03
                ),),

              ],
            ),
          )
        ],
      ),
    );
  }
}