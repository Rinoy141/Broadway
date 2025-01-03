
// import 'package:animated_rating_stars/animated_rating_stars.dart';
// import 'package:broadway/Buy%20and_sell/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../common/images.dart';
import '../view/payment.dart';

class ProductPurchase extends StatefulWidget {
  const ProductPurchase({super.key});

  @override
  State<ProductPurchase> createState() => _ProductPurchaseState();
}

class _ProductPurchaseState extends State<ProductPurchase> {
  int? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.arrow_left, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Review",
                style:
                TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.08),
              ),
              SizedBox(height: h * 0.04),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => payment()),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(theImages.food),
                    SizedBox(width: w * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vancho Pastries",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.05),
                        ),
                        Text(
                          "Fort Kochi, Main road",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: h * 0.04),
                        Text("6 pcs"),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: h * 0.03,
                color: thecolors.gray,
                thickness: w * 0.003,
              ),
              Row(
                children: [
                  Text("4.8"),
                  // AnimatedRatingStars(
                  //   initialRating: 3.5,
                  //   minRating: 0.0,
                  //   maxRating: 5.0,
                  //   filledColor: Colors.amber,
                  //   emptyColor: Colors.grey,
                  //   filledIcon: Icons.star,
                  //   halfFilledIcon: Icons.star_half,
                  //   emptyIcon: Icons.star_border,
                  //   onChanged: (double rating) {
                  //     // Handle the rating change here
                  //     print('Rating: $rating');
                  //   },
                  //   displayRatingValue: true,
                  //   interactiveTooltips: true,
                  //   customFilledIcon: Icons.star,
                  //   customHalfFilledIcon: Icons.star_half,
                  //   customEmptyIcon: Icons.star_border,
                  //   starSize: 15,
                  //   animationDuration:
                  //   Duration(milliseconds: 300),
                  //   animationCurve: Curves.easeInOut,
                  //   readOnly: false,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

