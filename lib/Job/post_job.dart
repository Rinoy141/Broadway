import 'package:broadway/common/colors.dart';
import 'package:broadway/common/images.dart';
import 'package:broadway/main.dart';
import 'package:broadway/view/product%20details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class postjob extends StatefulWidget {
  const postjob({super.key});

  @override
  State<postjob> createState() => _postjobState();
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
class _postjobState extends State<postjob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thecolors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
        title: Text('Post a Job',style: TextStyle(
            color: thecolors.secondary,
            fontSize: w*0.07,
            fontWeight: FontWeight.w600
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h*0.04,),
              Text("Job Title"),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "Add job title, role vacancies etc",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text("Job Role"),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "Select",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Salary'),
              SizedBox(height: h*0.01),
              Row(
                children: [
                  Container(
                    width: w*0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: thecolors.gray3,
                          filled: true,
                          hintText: "Min Salary",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.05),
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: w*0.03,),
                  Container(
                    width: w*0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: thecolors.gray3,
                          filled: true,
                          hintText: "Max Salary",
                          suffixIcon: Image.asset(theImages.rupee),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w*0.05),
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.01),
              Text('Job Type'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Job Qualification'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Vaccancies'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Experience level'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Job Location'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.04),
              Container(
                child:  DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  hint: Text(" country"),
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
              SizedBox(height: h*0.02,),
              Container(
                child: DropdownButtonFormField<String>(
                  value: selectedCity,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Select City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
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
              SizedBox(height: h*0.01),
              Text('Company Name'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Company License'),
              SizedBox(height: h*0.01),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      fillColor: thecolors.gray3,
                      filled: true,
                      hintText: "enter",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w*0.05),
                      )
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Text('Job Description'),
              SizedBox(height: h*0.01),
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
              SizedBox(height: h*0.01),
              Center(
                child: Container(
                  height: w*0.14,
                  width: w*0.6,
                  decoration: BoxDecoration(
                    color: thecolors.blow2,
                    borderRadius: BorderRadiusDirectional.circular(w*0.03),
                  ),
                  child: Center(
                    child: Text("Upload Logo",style: TextStyle(
                        color: CupertinoColors.white
                    )),
                  ),
                ),
              ),
              SizedBox(height: h*0.01),
              Center(
                child: Container(
                  height: w*0.14,
                  width: w*0.6,
                  decoration: BoxDecoration(
                    color: thecolors.blow2,
                    borderRadius: BorderRadiusDirectional.circular(w*0.03),
                  ),
                  child: Center(
                    child: Text("Post Job",style: TextStyle(
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