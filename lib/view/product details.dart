
import 'package:broadway/view/upload_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/images.dart';
import '../main.dart';

class productdetails extends StatefulWidget {
  const productdetails({super.key});

  @override
  State<productdetails> createState() => _productdetailsState();
}
//state
final List<String> _states = [
  'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
  'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand',
  'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur',
  'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab',
  'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura',
  'Uttar Pradesh', 'Uttarakhand', 'West Bengal'
];
//contries demo
final List<String> _countries = [
  'India', 'United States', 'United Kingdom', 'Canada', 'Australia',
  'Germany', 'France', 'China', 'Japan', 'Russia', 'Brazil'

];
List<String> cities = [
  'Kochi',
  'Aluva',
  'Perumbavoor',
  'Kakkanad',
  'Muvattupuzha',
  'Angamaly',
  'Thrippunithura',
  'Piravom'
];
String? _selectedState;
String? _selectedCountry;
String? selectedCity;
class _productdetailsState extends State<productdetails> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Container(child: Icon(CupertinoIcons.arrow_left,color: Colors.black,)))
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h*0.03,),
              Text("Product Details",style: TextStyle(
                color: Colors.black,
                fontSize: w*0.06,
                fontWeight: FontWeight.w700
              ),),
              SizedBox(height: h*0.02,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: thecolors.gray3,
                            filled: true,
                            hintText: "Add  product title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w*0.05),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(height: h*0.02,),
              Text("GSTIN"),
              SizedBox(height: h*0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: thecolors.gray3,
                          filled: true,
                          hintText: "Enter GSTIN",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.05),
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.02),
              Text("Pricing"),
              SizedBox(height: h*0.02,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        fillColor: thecolors.gray3,
                        filled: true,
                        suffixIcon: Image.asset(theImages.rupee),
                          hintText: "Amount /per kg",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.05),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.02,),
              Text("Sell Across "),
              SizedBox(height: h*0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        fillColor: thecolors.gray3,
                        filled: true,
                          hintText: "Enter GSTIN",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.05),
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.02),
              // Container(
              //   child:  Text("Country"),
              //   SizedBox(height: 10),
              //   DropdownButtonFormField<String>(
              //     value: _selectedCountry,
              //     hint: Text("Select Country"),
              //     items: _countries.map((String country) {
              //       return DropdownMenuItem<String>(
              //         value: country,
              //         child: Text(country),
              //       );
              //     }).toList(),
              //     onChanged: (newValue) {
              //       setState(() {
              //         _selectedCountry = newValue;
              //       });
              //     },
              //     decoration: InputDecoration(
              //       fillColor: Colors.grey[200],
              //       filled: true,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child:  DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  hint: Text("Select country"),
                  items: _countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    fillColor:thecolors.gray3,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                    ),
                  ),
                ),
                // child: TextFormField(
              ),
              SizedBox(height: h*0.02),
              Container(
                child:  DropdownButtonFormField<String>(
                  value: _selectedState,
                  hint: Text("Select State"),
                  items: _states.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedState = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    fillColor:thecolors.gray3,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                    ),
                  ),
                ),
                // child: TextFormField(
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   decoration: InputDecoration(
                //       suffixIcon: Icon(CupertinoIcons.chevron_down),
                //       hintText: "State",
                //       fillColor: thecolors.gray3,
                //       filled: true,
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(w*0.05),
                //       )
                //   ),
                // ),
              ),
              SizedBox(height: h*0.02),
              // Container(
              //   child: TextFormField(
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     decoration: InputDecoration(
              //       fillColor: thecolors.gray3,
              //         filled: true,
              //         suffixIcon: Icon(CupertinoIcons.chevron_down),
              //         hintText: "City",
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(w*0.05),
              //         )
              //     ),
              //   ),
              // ),
          Container(
            child: DropdownButtonFormField<String>(
              value: selectedCity, // Selected city from the dropdown
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                fillColor: thecolors.gray3, // Replace with your color
                filled: true,
                hintText: "Select City",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(w * 0.05), // Rounded border
                ),
              ),
              // icon: Icon(CupertinoIcons.chevron_down),
              items: cities.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
            ),
          ),
              SizedBox(height: h*0.02),
              Text("Product Description"),
              SizedBox(height: h*0.02),
              Container(
                child: TextFormField(
                   keyboardType: TextInputType.multiline,
                     maxLines: 10,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                      filled: true ,
                      hintText: "Describe briefly about your product",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.03),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>UploadImage(),));
                  },
                  child: Container(
                    height: w*0.14,
                    width: w*0.6,
                    decoration: BoxDecoration(
                      color: thecolors.blow2,
                      borderRadius: BorderRadiusDirectional.circular(w*0.03),
                    ),
                    child: Center(
                      child: Text("Upload Images",style: TextStyle(
                          color: CupertinoColors.white
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h*0.03),
              Center(
                child: Container(
                  height: w*0.14,
                  width: w*0.6,
                  decoration: BoxDecoration(
                    color: thecolors.blow2,
                    borderRadius: BorderRadiusDirectional.circular(w*0.03),
                  ),
                  child: Center(
                    child: Text("Post Add",style: TextStyle(
                        color: CupertinoColors.white
                    )),
                  ),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
}
