
import 'package:broadway/common/colors.dart';
import 'package:flutter/material.dart';
class OneJobDesc extends StatelessWidget {

  final Map<String, dynamic> jobData;

  const OneJobDesc({super.key, required this.jobData});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(jobData['name'] ?? "Job Details"),
      ),
      body: Column(
        children: [
          SizedBox(height: h * 0.02),
          Center(
            child: Container(
              height: h * 0.75,
              width: w * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(w * 0.03),
              ),
              child: Column(
                children: [
                  SizedBox(height: h * 0.01),
                  Container(
                    height: h * 0.4,
                    width: w * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(w * 0.04),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(w * 0.04),
                      child: jobData['image'] != null
                          ? Image.asset(
                        jobData['image'],
                        fit: BoxFit.cover,
                      )
                          : Center(child: Text("No Image Available")),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: EdgeInsets.all(w * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobData['name'] ?? '',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Text(
                          jobData['jobname'] ?? '',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        Text(
                          'Job Description:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Text(jobData['help'] ?? 'No description available'),
                        SizedBox(height: h * 0.01),
                        Text(jobData['support'] ?? 'No support details available'),
                      ],
                    ),
                  ),
                  Container(
                    height: h*0.04,
                    width: w*0.5,
                    decoration: BoxDecoration(
                      color: thecolors.primaryColor,
                      borderRadius: BorderRadiusDirectional.circular(w*0.04),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(w*0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Qualifications"),
                          SizedBox(width: w*0.05,),
                          Icon(Icons.archive_rounded)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: h*0.01),
          Container(
            height: h*0.07,
            width: w*0.4,
            decoration:  BoxDecoration(
                color: thecolors.blow2,
                borderRadius: BorderRadiusDirectional.circular(w*0.03)
            ),
            child: Center(child: Text('Apply Now',style: TextStyle(
                color: thecolors.primaryColor
            ),)),
          )
        ],
      ),
    );
  }
}