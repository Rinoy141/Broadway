import 'package:broadway/common/colors.dart';
import 'package:broadway/common/images.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class peopleapplied extends StatefulWidget {
  const peopleapplied({super.key});

  @override
  State<peopleapplied> createState() => _peopleappliedState();
}
List profile=[
  {
    "image":theImages.uxdesigner,
    "name":"Will Parker",
    "profession":"UX designer",
    "qualifications":"Qualification",
    "project":"Projects completed",
    "Review":"Reviews",
    "degree":"BSc CS",
    "project qty":"200",
    "Review qty":"140"
  },
  {
    "image":theImages.graphicdesigner,
    "name":"Alan Robert",
    "profession":"Graphics designer",
    "qualifications":"Qualification",
    "project":"Projects completed",
    "Review":"Reviews",
    "degree":"BTech CS",
    "project qty":"160",
    "Review qty":"102"
  },
  {
    "image":theImages.youtuber,
    "name":"Ran Williams",
    "profession":"Youtube Thumbnail designer",
    "qualifications":"Qualification",
    "project":"Projects completed",
    "Review":"Reviews",
    "degree":"B.Voc IT",
    "project qty":"45",
    "Review qty":"33"
  },
  {
    "image":theImages.BrandStrategist,
    "name":"Alok Kumar",
    "profession":"Brand Strategist",
    "qualifications":"Qualification",
    "project":"Projects completed",
    "Review":"Reviews",
    "degree":"BCA",
    "project qty":"150",
    "Review qty":"80"
  },
  {
    "image":theImages.uidesigner,
    "name":"Ali Ahmad",
    "profession":"UI designer",
    "qualifications":"Qualification",
    "project":"Projects completed",
    "Review":"Reviews",
    "degree":"BTech CS",
    "project qty":"543",
    "Review qty":"444"
  }
];

class _peopleappliedState extends State<peopleapplied> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          Container(
            height: h*0.25,
            width: w*0.99,
            color: thecolors.skyblue,
            child: Padding(
              padding:  EdgeInsets.all(w*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h*0.03,),
                  Text("Figma"),
                  Text("Inc"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sr. UX Researcher",style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: w*0.05
                        ),),
                        Image.asset(theImages.jobs)
                      ]
                  ),
                  Container(
                    height: h*0.04,
                    width: w*0.32,
                    decoration: BoxDecoration(
                        color: thecolors.gray3,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadiusDirectional.circular(w*0.06)
                    ),
                    child: Center(child: Text("Delete Post")),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(height: h*0.02),
          Text('Applications Recieved',style: TextStyle(
              fontSize: w*0.05,
              fontWeight: FontWeight.w700
          ),),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: h * 0.20,
                  width: w * 0.45,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: thecolors.gray1,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(w*0.03),
                    child: Column(

                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(profile[index]["image"]),
                            SizedBox(width: w*0.03,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile[index]["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: h*0.01),
                                Text(
                                  profile[index]["profession"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Divider(
                                  height: h*0.03,
                                  thickness: w*0.03,
                                  color: thecolors.gray,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(profile[index]["qualifications"],style: TextStyle(
                                                color: thecolors.black
                                            )),
                                            SizedBox(height: h*0.01,),
                                            Text(profile[index]["degree"]),
                                          ],
                                        ),
                                        SizedBox(width: w*0.03,),
                                        Column(
                                          children: [
                                            Text(profile[index]["project"],style: TextStyle(
                                                color: thecolors.black
                                            )),
                                            SizedBox(height: h*0.01,),
                                            Text(profile[index]["project qty"]),
                                          ],
                                        ),
                                        SizedBox(width: w*0.03,),
                                        SizedBox(height: h*0.03,),
                                        Column(
                                          children: [
                                            Text(profile[index]["Review"],style: TextStyle(
                                                color: thecolors.black
                                            ),),
                                            SizedBox(height: h*0.01,),
                                            Text(profile[index]["Review qty"])
                                          ],
                                        ),
                                        SizedBox(width: w*0.03,),
                                      ],
                                    ),


                                  ],
                                )
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: h*0.02,); // Adds space between items
              },
              itemCount: profile.length,
            ),
          ),
          SizedBox(height: h*0.03,)
        ],
      ),
    );
  }
}
