


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/images.dart';


class BuyOne extends StatefulWidget {
   BuyOne({super.key});


  @override
  State<BuyOne> createState() => _BuyOneState();
}
//profile
List elipe = [
  {
    'image': theImages.elipse,
    'name': "Vishnu V N,",
  },
  {
    "image": theImages.elipse1,
    "name": "Akhil P",
  },
  {
    "image": theImages.elipse2,
    "name": "Anand CL",
  },
  {
    "image": theImages.elipse3,
    "name": "Ranjith P",
  },
  {
    "image": theImages.elipse4,
    "name": "Joel A B",
  },
];
//based on search cacks
List cakes=[
  {
    "image":theImages.blackforest,
    "name":"Chocolate Icing",
    "product":"Cake",
    "price":"699 Rs",
  },
  {
    "image":theImages.chocolate,
    "name":"Black Forest  Icing",
    "product":"Cake",
    "price":"799 Rs",
  },
  {
    "image":theImages.blackforest,
    "name":"Chocolate Icing",
    "product":"Cake",
    "price":"699 Rs",
  },
];
List mango=[
  {
    "image":theImages.saltedmango,
    "Name":"saltedmango",
    "products":"mango",
    "RS":"100 Rs",
  },
  {
    "image":theImages.saltedmango,
    "Name":"saltedmango",
    "products":"mango",
    "RS":"150 Rs",
  },
  {
    "image":theImages.saltedmango,
    "Name":"saltedmango",
    "products":"mango",
    "RS":"200 Rs",
  },
];
class _BuyOneState extends State<BuyOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.45,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            theImages.sideview,
                            height: MediaQuery.of(context).size.height * 0.90,
                            width: MediaQuery.of(context).size.width * 0.7,
                            // fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.06),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                               bottom: MediaQuery.of(context).size.height * 0.12,
                              left: MediaQuery.of(context).size.width * 0.02,
                              child: Container(
                                child: Image.asset(
                                  theImages.sideview2,
                                  height: MediaQuery.of(context).size.height * 0.36,
                                  width: MediaQuery.of(context).size.width * 0.36,
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Centered TextFormField and Text widget
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: thecolors.secondary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                                ),
                                filled: true,
                                fillColor: thecolors.skyblue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          "Browse Sellers",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.05,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Container(
                         height: 200,
                          width: MediaQuery.of(context).size.width * 1,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: elipe.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: MediaQuery.of(context).size.width * 0.08,
                                            backgroundImage: AssetImage(elipe[index]['image']),
                                          ),
                                          // SizedBox(height: h * 0.01),
                                        ],
                                      ),
                                    ),
                                    Text(elipe[index]['name'],style: TextStyle(
                                        color: Colors.black
                                    )),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: h*0.04,),
            Container(
              height: MediaQuery.of(context).size.height*0.51,
              // width: ,
              decoration: BoxDecoration(
                  color: thecolors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MediaQuery.of(context).size.height*0.1),
                  // topRight: Radius.circular(w*0.1),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.all(MediaQuery.of(context).size.height*0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height*0.01),
                    Text("Based on your search"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 09,
                                spreadRadius: 09,
                                offset: Offset(0, 4),
                              ),
                            ],
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
                          ),
                          child: Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return  Container(
                                      height: MediaQuery.of(context).size.height*0.01,
                                      width:MediaQuery.of(context).size.width*0.3 ,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.03),
                                      color: thecolors.gray4,
                                    ),
                                   child: Column(
                                       children: [
                                         Image.asset(cakes[index]["image"]),
                                         Text(cakes[index]['name'],style: TextStyle(
                                           fontWeight: FontWeight.w700
                                         ),),
                                         Text(cakes[index]["product"],style: TextStyle(
                                           fontWeight: FontWeight.w700,
                                         )),
                                         SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text(cakes[index]["price"],style: TextStyle(
                                               fontWeight: FontWeight.w700,
                                               color: Colors.blue
                                             ),),
                                            // SvgPicture.asset(theImages.shopping)
                                             Icon(Icons.shopping_cart_outlined,color: Colors.blue,)
                                           ],
                                         )
                                       ],
                                   ),
                                    );
                                },
                                separatorBuilder:(context, index) => SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                                itemCount: cakes.length
                            ),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01),
                    Text("Nearby You",style: TextStyle(
                      fontWeight: FontWeight.w500
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 09,
                                spreadRadius: 09,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: mango.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                                  color: Colors.grey[300],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        mango[index]["image"] ?? 'assets/images/default.png',
                                        height: MediaQuery.of(context).size.height * 0.045,
                                        width: MediaQuery.of(context).size.width * 0.25,
                                        // fit: BoxFit.cover,
                                      ),
                                      Text(
                                        mango[index]['Name'] ?? 'Unknown Mango',
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        mango[index]["products"] ?? 'Unknown Product',
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            mango[index]["RS"] ?? 'N/A',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Icon(Icons.shopping_cart_outlined, color: Colors.blue),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          ),
                        ) ],
                    ),
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
