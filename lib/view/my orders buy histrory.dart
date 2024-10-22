

import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/images.dart';
import 'enqueries recieved.dart';


class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

List items = [
  {
    "image": theImages.blackforest,
    "itemname": "Black Forest Icing Cake",
    "price": "699 Rs",
    "location": "Thrissur, Kerala",
  },
  {
    "image": theImages.saltedmango,
    "itemname": "Salted Mango",
    "price": "699 Rs",
    "location": "Kochi, Kerala",
  },
  {
    "image": theImages.chocolate,
    "itemname": "Chocolate Icing Cake",
    "price": "399 Rs",
    "location": "Kozhikode, Kerala",
  },
  {
    "image": theImages.saltedmango,
    "itemname": "Kitchen Keeper",
    "price": "Chicking",
    "location": "Alberta, Canada",
  },
  {
    "image": theImages.blackforest,
    "itemname": "Black Forest Icing Cake",
    "price": "699 Rs",
    "location": "Thrissur, Kerala",
  },
];

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
              child: Container(child: Icon(Icons.arrow_back,color: thecolors.secondary,))),
          title: Text(
            "History",
            style: TextStyle(color: thecolors.secondary),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              Tab(text: "Buy"),
              Tab(text: "Sale"),
            ],
            labelColor: thecolors.secondary,
            indicatorColor: thecolors.secondary,
          ),
        ),
        body: TabBarView(
          children: [
            buildOrderTab(context, "Buy Orders"),
            buildSaleList(context),
          ],
        ),
      ),
    );
  }
  Widget buildOrderTab(BuildContext context, String orderType) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(theImages.empty),
          SizedBox(height: 20),
          Text(
            "There are no ongoing $orderType right now.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "You can order from home.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget buildSaleList(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(w* 0.03),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => enquiriesrecieved(),));
          },
          child: Container(
            height: h*0.1,
            width: w*1,
            decoration: BoxDecoration(
                color: thecolors.gray1,
                borderRadius: BorderRadius.circular(w * 0.04),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: Image.asset(
                items[index]['image'],
                width: 50,
                height: 50,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(items[index]['itemname'],style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: thecolors.secondary,
                    fontSize: w*0.04
                  )),
                  SizedBox(height: h*0.01,),
                  Text(items[index]['price'],style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: w*0.04,
                    color: thecolors.secondary
                  )),
                  SizedBox(height: h*0.01,),
                  Text(items[index]['location'],style: TextStyle(
                    fontSize: w*0.04,
                    fontWeight: FontWeight.w500,
                    color: thecolors.secondary
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
