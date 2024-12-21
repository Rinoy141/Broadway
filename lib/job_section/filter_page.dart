import 'package:broadway/common/colors.dart';
import 'package:broadway/common/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class filterpage extends StatefulWidget {
  const filterpage({super.key});

  @override
  State<filterpage> createState() => _filterpageState();
}

class _filterpageState extends State<filterpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(child: Icon(Icons.arrow_back))),
        centerTitle: true,
        title: Text('FILTER',style: TextStyle(
            fontWeight: FontWeight.w700
        ),),
        actions: [
          Padding(
            padding:  EdgeInsets.all(w*0.03),
            child: Text('Reset',style: TextStyle(
                fontWeight: FontWeight.w700,
                color: thecolors.blow2
            ),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h*0.04,),
              Text('Job Title',style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Design",
                      prefixIcon: Image.asset(theImages.design),
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.04,),
              Text('Job Type',style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Full Time",
                      prefixIcon: Image.asset(theImages.time),
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.04,),
              Text('Experience Level',style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Image.asset(theImages.entry),
                      hintText: "Entry Level",
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.04,),
              Text('Job Location',style: TextStyle(
                  fontWeight: FontWeight.w700
              ),),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter your Location",
                      prefixIcon: Image.asset(theImages.location),
                      border: OutlineInputBorder(
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.04,),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Salary',style: TextStyle(
                          fontWeight: FontWeight.w700
                      ),),
                      Container(
                        width: w*0.4,
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(theImages.rupees),
                              hintText: "2000",
                              border: OutlineInputBorder(
                              )
                          ),
                        ),
                      ),
                      Text('Min')
                    ],
                  ),
                  SizedBox(width: w*0.07),

                  Column(
                    children: [
                      SizedBox(height: w*0.05),
                      Container(
                        width: w*0.4,
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Image.asset(theImages.rupees),
                              hintText: "7000",
                              border: OutlineInputBorder(
                              )
                          ),
                        ),
                      ),
                      Text('Max')
                    ],
                  ),
                ],
              ),
              SizedBox(height: h*0.03,),
              Center(
                child: Container(
                  height: w*0.14,
                  width: w*0.6,
                  decoration: BoxDecoration(
                    color: thecolors.blow2,
                    borderRadius: BorderRadiusDirectional.circular(w*0.03),
                  ),
                  child: Center(
                    child: Text("Show Results",style: TextStyle(
                        color: CupertinoColors.white
                    )),
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
