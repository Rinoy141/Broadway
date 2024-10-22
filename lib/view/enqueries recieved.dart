
import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/images.dart';


class enquiriesrecieved extends StatefulWidget {
  const enquiriesrecieved({super.key});

  @override
  State<enquiriesrecieved> createState() => _enquiriesrecievedState();

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
class _enquiriesrecievedState extends State<enquiriesrecieved> {

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: thecolors.primaryColor,
        elevation: 0,
        leading:  InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(child: Icon(Icons.arrow_back,color: thecolors.secondary,))),
      ),
   body: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       SizedBox(height: h*0.01),
       Container(
         height: h*0.3,
         width: w*0.3,
         color: thecolors.skyblue,
         child: Padding(
           padding:  EdgeInsets.all(w*0.03),
           child: Row(
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: h*0.14),
                   Text("Amal John Bakes.  Inc."),
                   SizedBox(height: h*0.01,),
                   Text("Chocolate Icing Cake",style: TextStyle(
                     fontSize: w*0.07,
                     fontWeight: FontWeight.w600
                   ),)
                 ],
               ),
               SizedBox(width: w*0.08),
               Image.asset(theImages.chocolate)
             ],
           ),
         ),
       ),
       SizedBox(height: h*0.03,),
       Text('Orders  Recieved',style: TextStyle(
         fontWeight: FontWeight.w700,
         fontSize: w*0.07
       ),),
       // Container(
       //   height: h*0.2,
       //   width: w*0.99,
       //   child: ListView.separated(
       //     scrollDirection: Axis.horizontal,
       //     physics: BouncingScrollPhysics(),
       //       shrinkWrap: true,
       //       itemBuilder: (context, index) {
       //         return Container(
       //           height: h*2,
       //           width: w*0.99,
       //           decoration: BoxDecoration(
       //             color: thecolors.gray1
       //           ),
       //           child: Row(
       //             children: [
       //               Column(
       //                 children: [
       //                   Text(profile[index]["name"]),
       //                   Text(profile[index]["profession"])
       //                 ],
       //               )
       //             ],
       //           ),
       //         );
       //       },
       //       separatorBuilder: (context, index) {
       //         return Text("");
       //       },
       //       itemCount: 4),
       // )
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
           // mainAxisAlignment: MainAxisAlignment.center,
           // crossAxisAlignment: CrossAxisAlignment.center,
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
    ]
   )
    );
  }
}
