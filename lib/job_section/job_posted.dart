
import 'dart:html';

import 'package:broadway/common/colors.dart';
import 'package:broadway/common/images.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class JobPosted extends StatefulWidget {
  const JobPosted({super.key});

  @override
  State<JobPosted> createState() => _JobPostedState();
}
class _JobPostedState extends State<JobPosted> {
  final List<Map<String, dynamic>> jobs = [
    {
      'image': theImages.jobs,
      'name': 'Sr. UX Researcher',
      'qualification': 'Figma',
      'role': 'Quebec, Canada'
    },
    {
      'image': theImages.jobs,
      'name': 'Sr. UI Researcher',
      'qualification': 'Figma',
      'role': 'Quebec, Canada'
    },
    {
      'image': theImages.jobs,
      'name': 'Assistant HR',
      'qualification': 'Figma',
      'role': 'Quebec, Canada'
    },
    {
      'image': theImages.jobs,
      'name': 'Jr. UI Researcher',
      'qualification': 'Figma',
      'role': 'Quebec, Canada'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thecolors.primaryColor,
      appBar: AppBar(
        backgroundColor: thecolors.primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Jobs Posted",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: h * 0.02),
              padding: EdgeInsets.all(w * 0.03),
              decoration: BoxDecoration(
                color: thecolors.gray,
                borderRadius: BorderRadius.circular(w * 0.04),
              ),
              child: Row(
                children: [
                  Image.asset(
                    jobs[index]['image'],
                    height: h * 0.08,
                    width: w * 0.15,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: w * 0.04),
                  // Job Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobs[index]['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: h * 0.005),
                        Text(
                          "Qualification: ${jobs[index]['qualification']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: h * 0.005),
                        Text(
                          "Role: ${jobs[index]['role']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
