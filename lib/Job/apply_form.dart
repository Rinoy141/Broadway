// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../common/colors.dart';
// import '../common/images.dart';

// class ApplyForm extends StatefulWidget {
//   const ApplyForm({super.key});

//   @override
//   State<ApplyForm> createState() => _ApplyFormState();
// }

// class _ApplyFormState extends State<ApplyForm> {
//   late double h, w;

//   String? resumeFilePath;
//   String? coverLetterFilePath;

//   Future<void> pickFile(String type) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );

//     if (result != null) {
//       setState(() {
//         if (type == 'resume') {
//           resumeFilePath = result.files.single.path;
//         } else if (type == 'coverLetter') {
//           coverLetterFilePath = result.files.single.path;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height;
//     w = MediaQuery.of(context).size.width;

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: Text(
//           'Apply Form',
//           style: TextStyle(fontWeight: FontWeight.w700, fontSize: w * 0.05),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(w * 0.03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               SizedBox(height: h * 0.04),
//               _buildTextField("Relevant Experience (in years)"),
//               SizedBox(height: h * 0.03),
//               _buildTextField("+Upload Portfolio link (if any)"),
//               SizedBox(height: h * 0.03),
//               _buildFilePickerField(
//                 "Upload Cover Letter",
//                 coverLetterFilePath,
//                     () => pickFile('coverLetter'),
//               ),
//               SizedBox(height: h * 0.03),
//               _buildFilePickerField(
//                 "Upload Resume",
//                 resumeFilePath,
//                     () => pickFile('resume'),
//               ),
//               SizedBox(height: h*0.03,),
//               Center(
//                 child: Container(
//                   height: w*0.14,
//                   width: w*0.6,
//                   decoration: BoxDecoration(
//                     color: thecolors.blow2,
//                     borderRadius: BorderRadiusDirectional.circular(w*0.03),
//                   ),
//                   child: Center(
//                     child: Text("Proceed",style: TextStyle(
//                         color: CupertinoColors.white
//                     )),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       height: h * 0.25,
//       width: double.infinity,
//       color: thecolors.skyblue,
//       child: Padding(
//         padding: EdgeInsets.all(w * 0.03),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: h * 0.03),
//             const Text("Figma"),
//             const Text("Inc"),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Text(
//                     "Sr. UX Researcher",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: w * 0.05,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Image.asset(
//                   theImages.jobs,
//                   width: w * 0.15,
//                   fit: BoxFit.contain,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String hint, {TextInputType? keyboardType}) {
//     return TextFormField(
//       keyboardType: keyboardType ?? TextInputType.text,
//       decoration: InputDecoration(
//         hintText: hint,
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget _buildFilePickerField(String hint, String? filePath, VoidCallback onPickFile) {
//     return GestureDetector(
//       onTap: onPickFile,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: h * 0.015, horizontal: w * 0.03),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 filePath != null
//                     ? filePath.split('/').last
//                     : hint,
//                 style: TextStyle(color: filePath != null ? Colors.black : Colors.grey),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Image.asset(theImages.pdf)
//           ],
//         ),
//       ),
//     );

//   }
// }