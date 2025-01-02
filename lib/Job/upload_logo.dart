
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../common/colors.dart';
import '../common/images.dart';
class UploadLogo extends StatefulWidget {
  const UploadLogo({Key? key}) : super(key: key);

  @override
  State<UploadLogo> createState() => _UploadLogoState();
}

class _UploadLogoState extends State<UploadLogo> {
  File? _file;
  final ImagePicker _picker = ImagePicker();

  double h = 0; // Initialize screen height
  double w = 0; // Initialize screen width

  Future<void> _pickFile(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
      _uploadFile(_file!);
    }
  }

  Future<void> _uploadFile(File file) async {
    // Implement file upload logic here
    print("Uploading file: ${file.path}");
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height; // Get screen height
    w = MediaQuery.of(context).size.width;  // Get screen width

    return Scaffold(
      backgroundColor: thecolors.primaryColor,
      floatingActionButton: InkWell(
        onTap: () {
          if (_file != null) {
            _uploadFile(_file!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please select an image to upload!")),
            );
          }
        },
        child: Container(
          height: h * 0.08,
          width: w * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.04),
            color: thecolors.blow2,
          ),
          child: Center(
            child: Text(
              "Upload",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: w * 0.06,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.arrow_left, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          children: [
            SizedBox(height: w * 0.04),
            Text(
              "Upload Logo",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: w * 0.07,
              ),
            ),
            SizedBox(height: w * 0.04),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickFile(ImageSource.camera);
                  },
                  child: Container(
                    height: h * 0.22,
                    width: w * 0.45,
                    color: thecolors.blow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.camera_fill,
                          color: CupertinoColors.white,
                          size: w * 0.3,
                        ),
                        SizedBox(height: w * 0.045),
                        Text(
                          "Camera",
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: w * 0.04),
                GestureDetector(
                  onTap: () {
                    _pickFile(ImageSource.gallery);
                  },
                  child: Container(
                    height: h * 0.22,
                    width: w * 0.45,
                    color: thecolors.blow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(theImages.upload, height: h * 0.17),
                        SizedBox(height: w * 0.01),
                        Text(
                          "Folders",
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.04),
            // Display the selected image
            if (_file != null)
              Container(
                height: h * 0.3,
                width: w * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: thecolors.blow2, width: 2),
                ),
                child: Image.file(_file!, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}