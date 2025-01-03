
import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../common/images.dart';

class Buyers extends StatefulWidget {
  const Buyers({super.key});

  @override
  State<Buyers> createState() => _BuyersState();
}

List elipe = [
  {'image': theImages.elipse, 'name': "Vishnu V N,"},
  {'image': theImages.elipse1, 'name': "Akhil P"},
  {'image': theImages.elipse2, 'name': "Anand CL"},
  {'image': theImages.elipse3, 'name': "Ranjith P"},
  {'image': theImages.elipse4, 'name': "Joel A B"},
];

class _BuyersState extends State<Buyers> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Allows the entire screen to scroll vertically
        child: Column(
          children: [
            Container(
              height: h * 0.45,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        theImages.sideview,
                        height: h * 0.90,
                        width: w * 0.7,
                      ),
                      SizedBox(width: w * 0.06),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: h * 0.12,
                              left: w * 0.02,
                              child: Image.asset(
                                theImages.sideview2,
                                height: h * 0.36,
                                width: w * 0.36,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: h * 0.15,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: Icon(
                          Icons.search,
                          color: thecolors.secondary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(w * 0.04),
                        ),
                        filled: true,
                        fillColor: thecolors.skyblue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: h * 0.9, // Adjust height if needed
              decoration: BoxDecoration(
                color: thecolors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(h * 0.1),
                  topRight: Radius.circular(h * 0.1),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Browse Sellers",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: elipe.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage(elipe[index]['image']),
                            ),
                            title: Text(
                              elipe[index]['name'],
                              style: TextStyle(color: Colors.black),
                            ),
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
    );
  }
}
