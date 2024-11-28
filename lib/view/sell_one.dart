

import 'package:broadway/view/product%20details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/images.dart';


class SellOne extends StatefulWidget {
  const SellOne({super.key});

  @override
  State<SellOne> createState() => _SellOneState();
}

class _SellOneState extends State<SellOne> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    Widget productTile(String imagePath, String label, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: w * 0.25,
              height: h * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w * 0.03),
              ),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
            SizedBox(height: h * 0.01),
            Text(label),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: thecolors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(CupertinoIcons.arrow_left, color: Colors.black)),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.03),
            Text(
              "What is your ",
              style: TextStyle(
                color: thecolors.secondary,
                fontSize: w * 0.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "product?",
              style: TextStyle(
                color: Colors.black,
                fontSize: w * 0.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h * 0.03),
            Divider(
              height: h * 0.03,
              thickness: w * 0.001,
              color: thecolors.secondary,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: productTile(
                        theImages.cake,
                        "Cakes, Pastries",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetails(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: h * 0.12,
                      color: thecolors.secondary,
                    ),
                    Expanded(
                      child: productTile(
                        theImages.vegitables,
                        "Vegetables",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetails(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: h * 0.07,
                  thickness: w * 0.001,
                  color: thecolors.secondary,
                ),
                Row(
                  children: [
                    Expanded(
                      child: productTile(
                        theImages.graps,
                        "Fruits",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetails(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: h * 0.12,
                      color: thecolors.secondary,
                    ),
                    Expanded(
                      child: productTile(
                        theImages.grocery,
                        "Grocery Items",
                            () {},
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: h * 0.03,
                  thickness: w * 0.001,
                  color: thecolors.secondary,
                ),
                Row(
                  children: [
                    Expanded(
                      child: productTile(
                        theImages.handicraft,
                        "Handicrafts",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetails(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: h * 0.12,
                      color: thecolors.secondary,
                    ),
                    Expanded(
                      child: productTile(
                        theImages.popcorn,
                        "Snacks",
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => productdetails(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: h * 0.07,
                  thickness: w * 0.001,
                  color: thecolors.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
