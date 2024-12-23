import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../Api_sarvice_job/profile_provider.dart';
import '../common/colors.dart';
import '../main.dart';

class ApplicationProfile extends StatefulWidget {
  const ApplicationProfile({super.key});

  @override
  State<ApplicationProfile> createState() => _ApplicationProfileState();
}
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController mobileController = TextEditingController();
final TextEditingController jobTitleController = TextEditingController();
final TextEditingController qualificationController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

class _ApplicationProfileState extends State<ApplicationProfile> {
  var file;
  String imageurl = "";
  pickFile(ImageSource) async {
    final pickedFile =
    await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(pickedFile!.path);
    if (mounted) {
      setState(() {
        file = File(pickedFile.path);
        //file = userImage;
      });
      // uploadFile(file);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thecolors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
              color: thecolors.secondary,
              fontSize: w * 0.07,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        Center(
                            child: file != null
                                ? CircleAvatar(
                              // backgroundColor: theColors.primaryColor,
                                radius: w * 0.15,
                                backgroundImage: FileImage(file))
                                :
                            CircleAvatar(
                              radius: w * 0.15,
                              // backgroundColor: theColors.secondary,
                              // backgroundImage:
                              // AssetImage(theImages.beckham),
                            )
                        ),
                        Positioned(
                          left: w * 0.18,
                          bottom: w * 0.001,
                          child: InkWell(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => Material(
                                    type: MaterialType.circle,
                                    color: Colors.transparent,
                                    child: CupertinoActionSheet(
                                        actions: <Widget>[
                                          CupertinoActionSheetAction(
                                            child: const Text('Photo Gallery'),
                                            onPressed: () {
                                              pickFile(ImageSource.gallery);
                                              Navigator.pop(context, 'One');
                                            },
                                          ),
                                          CupertinoActionSheetAction(
                                            child: const Text('Camera'),
                                            onPressed: () {
                                              pickFile(ImageSource.camera);
                                              Navigator.pop(context, 'Two');
                                            },
                                          )
                                        ],
                                        cancelButton: CupertinoActionSheetAction(
                                          child: Text('Cancel',style: TextStyle(
                                            // color: theColors.thirteen
                                          )),
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                        )),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: w * 0.04,
                                // backgroundColor: theColors.third,
                                child: Center(
                                    child: Icon(
                                      CupertinoIcons.pen,
                                      // color: theColors.primaryColor,
                                    )),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: h * 0.01),
                Text("Name"),
                SizedBox(height: h * 0.01),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text("Email"),
                SizedBox(height: h * 0.01),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text("Mobile Number"),
                SizedBox(height: h * 0.01),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Enter your mobile number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text("Job Title"),
                SizedBox(height: h * 0.01),
                TextFormField(
                  controller: jobTitleController,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Add job title, role, vacancies, etc.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text("Job Qualification"),
                SizedBox(height: h * 0.01),
                TextFormField(
                  controller: qualificationController,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Enter qualification",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Text('Description'),
                SizedBox(height: h * 0.01),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    fillColor: thecolors.gray3,
                    filled: true,
                    hintText: "Add your description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w * 0.05),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Center(
                  child: Container(
                    height: w * 0.14,
                    width: w * 0.6,
                    decoration: BoxDecoration(
                      color: thecolors.blow2,
                      borderRadius: BorderRadiusDirectional.circular(w * 0.03),
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );

  }
}
