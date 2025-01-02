import 'package:broadway/main.dart';
import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../common/images.dart';


class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}
List  jobs= [
  {
    'image': theImages.jobs,
    'missing': "You might have missed : 16 jobs",
    'applies':'similar to your recent applies.',
    'simular':'Jobs based on your applies'
  },
  {
    "image": theImages.jobs,
    'missing': "Your resume for job application was ",
    'applies':'viewed.  ',
    'simular':'Application status'
  },
  {
    "image": theImages.jobs,
    'missing': "Highlight your job application by  ",
    'applies':'creating a video profile.',
    'simular':'Video Profile'
  },
  {
    "image": theImages.jobs,
    'missing': "Your application was viewed by ",
    'applies':'recruiter.     ',
    'simular':'Application status'
  },
  {
    "image": theImages.jobs,
    'missing': "Your resume is just 50% of you.  ",
    'applies':'Complete your resume.',
    'simular':'Profile Progress'
  },
];
class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          centerTitle: true,
          title: Text('Stay up to Date',style: TextStyle(
              fontWeight: FontWeight.w700
          ),),
        ),
        body:Column(
          children: [
            SizedBox(height: h*0.03,),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: h * 0.13,
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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(jobs[index]["image"]),
                              SizedBox(width: w*0.03,),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobs[index]["missing"],
                                      style: TextStyle(
                                      ),
                                    ),
                                    SizedBox(height: h*0.01),
                                    Text(
                                      jobs[index]["applies"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(jobs[index]["simular"])
                                  ]),
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
                itemCount: jobs.length,
              ),
            ),
            SizedBox(height: h*0.03,)
          ],
        )
    );
  }
}