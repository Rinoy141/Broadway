// import 'dart:html';
//
// import 'package:boardway/common/colers.dart';
// import 'package:boardway/common/images.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../main.dart';
//
// class uploadimage extends StatefulWidget {
//   const uploadimage({super.key});
//
//   @override
//   State<uploadimage> createState() => _uploadimageState();
// }
// // Function to pick an image
// pickFile(ImageSource source) async {
//   final pickedFile = await ImagePicker().pickImage(source: source);
//
//   if (pickedFile != null) {
//     setState(() {
//       file = File(pickedFile.path);  // Store the selected file
//     });
//     uploadFile(file);  // Assuming you have this function defined
//   }
// }
//
// // Dummy upload function (define it based on your needs)
// uploadFile(File file) {
//   // Upload logic here
// }
//
// var file;
// class _uploadimageState extends State<uploadimage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton:Container(
//         height: h*0.08,
//         width: w*0.9,
//         decoration: BoxDecoration(
//             borderRadius:BorderRadiusDirectional.circular(w*0.04),
//           color: thecolors.blow2,
//         ),
//        child: Center(child: Text("Upload",style: TextStyle(
//          color: Colors.white,
//          fontWeight: FontWeight.w300,
//          fontSize: w*0.06
//        ),)),
//       ),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: CupertinoColors.white,
//         leading: Icon(CupertinoIcons.arrow_left,color: Colors.black,),
//       ),
//       body: Padding(
//         padding:  EdgeInsets.all(w*0.03),
//         child: Column(
//           children: [
//             SizedBox(height: w*0.04,),
//             Text("Upload Images",style: TextStyle(
//               fontWeight: FontWeight.w700,
//               fontSize: w*0.07
//             )),
//             SizedBox(height: w*0.04,),
//             Row(
//               children: [
//                 Container(
//                   height: h*0.22,
//                   width: w*0.45,
//                   color: thecolors.blow,
//                   child: Column(
//                     children: [
//                       Icon(CupertinoIcons.camera_fill,color: CupertinoColors.white,size: w*0.3),
//                       SizedBox(height: w*0.045),
//                       Text("Camera",style: TextStyle(
//                         color: CupertinoColors.white,
//                         fontWeight: FontWeight.w600
//                       ),)
//                     ],
//
//                   ),
//                 ),
//                 SizedBox(width: w*0.04),
//                 Container(
//                   height: h*0.22,
//                   width: w*0.45,
//                   color: thecolors.blow,
//                   child: Column(
//                     children: [
//                       Image.asset(theImages.upload,height: h*0.17),
//                        SizedBox(height: w*0.01),
//                       Text("Folders",style: TextStyle(
//                           color: CupertinoColors.white,
//                           fontWeight: FontWeight.w600
//                       ),)
//                     ],
//
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       )
//     );
//   }
// }
import 'dart:io';  // Use dart:io for file handling in mobile apps

import 'package:broadway/view/product_parchase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../common/colors.dart';
import '../common/images.dart';
import '../main.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  var file;

  // Function to pick an image
  pickFile(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
      uploadFile(file);
    }
  }


  uploadFile(File file) {
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: thecolors.primaryColor,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => productparchase(),));
        },
        child: Container(
          height: h * 0.08,
          width: w * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(w * 0.04),
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
            child: Container(child: Icon(CupertinoIcons.arrow_left, color: Colors.black))),
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          children: [
            SizedBox(height: w * 0.04),
            Text(
              "Upload Images",
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
                    pickFile(ImageSource.camera);  // Open the camera to pick an image
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
                    pickFile(ImageSource.gallery);  // Open the gallery to pick an image
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
            if (file != null)
              Container(
                height: h * 0.3,
                width: w * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: thecolors.blow2, width: 2),
                ),
                child: Image.file(file!, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}
