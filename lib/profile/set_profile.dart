// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import '../food_app/state providers/set_profile_provider.dart';
// // // import '../providerss/app_provider.dart';

// // // class SetProfilePage extends StatefulWidget {
// // //   @override
// // //   SetProfilePageState createState() => SetProfilePageState();
// // // }

// // // class SetProfilePageState extends State<SetProfilePage> {
// // //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // Initialize provider data
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       final profileSetupProvider =
// // //       Provider.of<ProfileSetupProvider>(context, listen: false);
// // //       final mainProvider =
// // //       Provider.of<MainProvider>(context, listen: false);

// // //       // Pre-fill email address
// // //       profileSetupProvider.addressController.text =
// // //           mainProvider.emailController.text;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MultiProvider(
// // //       providers: [
// // //         ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
// // //         ChangeNotifierProvider(create: (_) => MainProvider()),
// // //       ],
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Set Profile'),
// // //         ),
// // //         body: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Consumer<ProfileSetupProvider>(
// // //             builder: (context, profileSetupProvider, _) {
// // //               return Consumer<MainProvider>(
// // //                 builder: (context, mainProvider, _) {
// // //                   return Form(
// // //                     key: _formKey,
// // //                     child: SingleChildScrollView(
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.center,
// // //                         children: [
// // //                           // Profile Image Picker
// // //                           GestureDetector(
// // //                             onTap: () => profileSetupProvider.pickImage(true),
// // //                             child: CircleAvatar(
// // //                               radius: 60,
// // //                               backgroundColor: Colors.grey[200],
// // //                               backgroundImage:
// // //                               profileSetupProvider.profileImage != null
// // //                                   ? FileImage(profileSetupProvider.profileImage!)
// // //                                   : null,
// // //                               child: profileSetupProvider.profileImage == null
// // //                                   ? Icon(Icons.camera_alt,
// // //                                   size: 50, color: Colors.grey[800])
// // //                                   : null,
// // //                             ),
// // //                           ),

// // //                           // Additional form fields
// // //                           TextFormField(
// // //                             controller: profileSetupProvider.countryController,
// // //                             decoration: InputDecoration(
// // //                               labelText: 'Country',
// // //                               border: OutlineInputBorder(),
// // //                             ),
// // //                             validator: (value) {
// // //                               if (value == null || value.isEmpty) {
// // //                                 return 'Please enter country';
// // //                               }
// // //                               return null;
// // //                             },
// // //                           ),

// // //                           TextFormField(
// // //                             controller: profileSetupProvider.districtController,
// // //                             decoration: InputDecoration(
// // //                               labelText: 'District',
// // //                               border: OutlineInputBorder(),
// // //                             ),
// // //                             validator: (value) {
// // //                               if (value == null || value.isEmpty) {
// // //                                 return 'Please enter district';
// // //                               }
// // //                               return null;
// // //                             },
// // //                           ),

// // //                           // ID Image Picker
// // //                           ElevatedButton(
// // //                             onPressed: () => profileSetupProvider.pickImage(false),
// // //                             child: Text('Pick ID Image'),
// // //                           ),

// // //                           MaterialButton(
// // //                             minWidth: 300,
// // //                             onPressed: () async {
// // //                               if (_formKey.currentState!.validate() &&
// // //                                   profileSetupProvider.validateForm()) {
// // //                                 await mainProvider.handleAddressUpdate(
// // //                                   context: context,
// // //                                   country: profileSetupProvider.countryController.text.trim(),
// // //                                   address: profileSetupProvider.addressController.text.trim(),
// // //                                   district: profileSetupProvider.districtController.text.trim(),
// // //                                   place: profileSetupProvider.placeController.text.trim(),
// // //                                   gender: profileSetupProvider.genderController.text.trim(),
// // //                                   profilePic: profileSetupProvider.profileImage,
// // //                                   idImage: profileSetupProvider.idImage,
// // //                                 );
// // //                               } else {
// // //                                 ScaffoldMessenger.of(context).showSnackBar(
// // //                                   SnackBar(
// // //                                     content: Text(
// // //                                         'Please fill all fields and upload both Profile Picture and ID Image'),
// // //                                   ),
// // //                                 );
// // //                               }
// // //                             },
// // //                             color: const Color(0xff004CFF),
// // //                             shape: OutlineInputBorder(
// // //                                 borderRadius: BorderRadius.circular(10)),
// // //                             child: const Text(
// // //                               'Submit your profile',
// // //                               style: TextStyle(color: Colors.white),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   );
// // //                 },
// // //               );
// // //             },
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'dart:io';
// // import '../providerss/app_provider.dart';

// // class SetProfilePage extends StatefulWidget {
// //   @override
// //   SetProfilePageState createState() => SetProfilePageState();
// // }

// // class SetProfilePageState extends State<SetProfilePage> {
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   late TextEditingController addressController;
// //   late TextEditingController countryController;
// //   late TextEditingController districtController;
// //   late TextEditingController placeController;
// //   late TextEditingController genderController;

// //   File? _profileImage;
// //   File? _idImage;
// //   bool isLoading = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     addressController = TextEditingController();
// //     countryController = TextEditingController();
// //     districtController = TextEditingController();
// //     placeController = TextEditingController();
// //     genderController = TextEditingController();

// //     final provider = Provider.of<MainProvider>(context, listen: false);
// //     addressController.text = provider.emailController.text;
// //   }

// //   @override
// //   void dispose() {
// //     addressController.dispose();
// //     countryController.dispose();
// //     districtController.dispose();
// //     placeController.dispose();
// //     genderController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> _pickImage(bool isProfilePic) async {
// //     final pickedFile =
// //         await ImagePicker().pickImage(source: ImageSource.gallery);

// //     if (pickedFile != null) {
// //       setState(() {
// //         if (isProfilePic) {
// //           _profileImage = File(pickedFile.path);
// //         } else {
// //           _idImage = File(pickedFile.path);
// //         }
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider<MainProvider>(
// //       create: (_) => MainProvider(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Set Profile'),
// //         ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Consumer<MainProvider>(
// //             builder: (context, loginProvider, _) {
// //               return Form(
// //                 key: _formKey,
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       GestureDetector(
// //                         onTap: () => _pickImage(true),
// //                         child: CircleAvatar(
// //                           radius: 60,
// //                           backgroundColor: Colors.grey[200],
// //                           backgroundImage: _profileImage != null
// //                               ? FileImage(_profileImage!)
// //                               : null,
// //                           child: _profileImage == null
// //                               ? Icon(Icons.camera_alt,
// //                                   size: 50, color: Colors.grey[800])
// //                               : null,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 16.0),
// //                       Text('Profile Picture'),
// //                       const SizedBox(height: 16.0),
// //                       TextFormField(
// //                         controller: addressController,
// //                         decoration: const InputDecoration(
// //                           labelText: 'Address',
// //                           border: OutlineInputBorder(
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(10))),
// //                         ),
// //                         validator: (value) => value == null || value.isEmpty
// //                             ? 'Address is required'
// //                             : null,
// //                       ),
// //                       const SizedBox(height: 16.0),
// //                       TextFormField(
// //                         controller: countryController,
// //                         decoration: const InputDecoration(
// //                           labelText: 'Country',
// //                           border: OutlineInputBorder(
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(10))),
// //                         ),
// //                         validator: (value) => value == null || value.isEmpty
// //                             ? 'Country is required'
// //                             : null,
// //                       ),
// //                       const SizedBox(height: 16.0),
// //                       TextFormField(
// //                         controller: districtController,
// //                         decoration: const InputDecoration(
// //                           labelText: 'District',
// //                           border: OutlineInputBorder(
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(10))),
// //                         ),
// //                         validator: (value) => value == null || value.isEmpty
// //                             ? 'District is required'
// //                             : null,
// //                       ),
// //                       const SizedBox(height: 16.0),
// //                       TextFormField(
// //                         controller: placeController,
// //                         decoration: const InputDecoration(
// //                           labelText: 'Place',
// //                           border: OutlineInputBorder(
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(10))),
// //                         ),
// //                         validator: (value) => value == null || value.isEmpty
// //                             ? 'Place is required'
// //                             : null,
// //                       ),
// //                       const SizedBox(height: 16.0),
// //                       TextFormField(
// //                         controller: genderController,
// //                         decoration: const InputDecoration(
// //                           labelText: 'Gender',
// //                           border: OutlineInputBorder(
// //                               borderRadius:
// //                                   BorderRadius.all(Radius.circular(10))),
// //                         ),
// //                         validator: (value) => value == null || value.isEmpty
// //                             ? 'Gender is required'
// //                             : null,
// //                       ),
// //                       const SizedBox(height: 16.0),
// //                       ElevatedButton(
// //                         onPressed: () => _pickImage(false),
// //                         child: Text(_idImage == null
// //                             ? 'Upload ID Image'
// //                             : 'Change ID Image'),
// //                       ),
// //                       if (_idImage != null)
// //                         Image.file(_idImage!,
// //                             height: 100, width: 100, fit: BoxFit.cover),
// //                       const SizedBox(height: 24.0),
// //                       // MaterialButton(
// //                       //   minWidth: 300,
// //                       //   onPressed: isLoading
// //                       //       ? null
// //                       //       : () async {
// //                       //           if (_formKey.currentState!.validate() &&
// //                       //               _profileImage != null &&
// //                       //               _idImage != null) {
// //                       //             setState(() {
// //                       //               isLoading = true;
// //                       //             });
// //                       //             await loginProvider.handleAddressUpdate(
// //                       //               context: context,
// //                       //               country: countryController.text.trim(),
// //                       //               address: addressController.text.trim(),
// //                       //               district: districtController.text.trim(),
// //                       //               place: placeController.text.trim(),
// //                       //               gender: genderController.text.trim(),
// //                       //               profilePic: _profileImage,
// //                       //               idImage: _idImage,
// //                       //             );
// //                       //             setState(() {
// //                       //               isLoading = false;
// //                       //             });
// //                       //           } else {
// //                       //             ScaffoldMessenger.of(context).showSnackBar(
// //                       //               SnackBar(
// //                       //                 content: Text(
// //                       //                     'Please upload both Profile Picture and ID Image'),
// //                       //               ),
// //                       //             );
// //                       //           }
// //                       //         },
// //                       //   color: const Color(0xff004CFF),
// //                       //   shape: OutlineInputBorder(
// //                       //       borderRadius: BorderRadius.circular(10)),
// //                       //   // child: isLoading
// //                       //   //     ? const CircularProgressIndicator(
// //                       //   //         color: Color(0xff004CFF),
// //                       //   //       )
// //                       //   //     : const Text(
// //                       //   //         'Submit your profile',
// //                       //   //         style: TextStyle(color: Color(0xff004CFF)),
// //                       //   //       ),

// //                       //   child: isLoading
// //                       //       ? const CircularProgressIndicator(
// //                       //           color: Color(
// //                       //               0xff004CFF),
// //                       //         )
// //                       //       : const Text(
// //                       //           'Submit your profile',
// //                       //           style: TextStyle(
// //                       //             color: Colors.white,
// //                       //           ),
// //                       //         ),
// //                       // ),

// //                       Container(
// //                         height:
// //                             60, // Increase this value to make the button taller
// //                         child: MaterialButton(
// //                           minWidth: 300,
// //                           onPressed: isLoading
// //                               ? null
// //                               : () async {
// //                                   if (_formKey.currentState!.validate() &&
// //                                       _profileImage != null &&
// //                                       _idImage != null) {
// //                                     setState(() {
// //                                       isLoading = true;
// //                                     });
// //                                     await loginProvider.handleAddressUpdate(
// //                                       context: context,
// //                                       country: countryController.text.trim(),
// //                                       address: addressController.text.trim(),
// //                                       district: districtController.text.trim(),
// //                                       place: placeController.text.trim(),
// //                                       gender: genderController.text.trim(),
// //                                       profilePic: _profileImage,
// //                                       idImage: _idImage,
// //                                     );
// //                                     setState(() {
// //                                       isLoading = false;
// //                                     });
// //                                   } else {
// //                                     ScaffoldMessenger.of(context).showSnackBar(
// //                                       SnackBar(
// //                                         content: Text(
// //                                             'Please upload both Profile Picture and ID Image'),
// //                                       ),
// //                                     );
// //                                   }
// //                                 },
// //                           color: const Color(0xff004CFF),
// //                           shape: OutlineInputBorder(
// //                               borderRadius: BorderRadius.circular(10)),
// //                           child: isLoading
// //                               ? const CircularProgressIndicator(
// //                                   color: Color(0xff004CFF),
// //                                 )
// //                               : const Text(
// //                                   'Submit your profile',
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                   ),
// //                                 ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../food_app/state providers/set_profile_provider.dart';
// import '../providerss/app_provider.dart';

// class SetProfilePage extends StatefulWidget {
//   @override
//   SetProfilePageState createState() => SetProfilePageState();
// }

// class SetProfilePageState extends State<SetProfilePage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize provider data
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final profileSetupProvider =
//       Provider.of<ProfileSetupProvider>(context, listen: false);
//       final mainProvider =
//       Provider.of<MainProvider>(context, listen: false);

//       // Pre-fill email address
//       profileSetupProvider.addressController.text =
//           mainProvider.emailController.text;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
//         ChangeNotifierProvider(create: (_) => MainProvider()),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Set Profile'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Consumer<ProfileSetupProvider>(
//             builder: (context, profileSetupProvider, _) {
//               return Consumer<MainProvider>(
//                 builder: (context, mainProvider, _) {
//                   return Form(
//                     key: _formKey,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Profile Image Picker
//                           GestureDetector(
//                             onTap: () => profileSetupProvider.pickImage(true),
//                             child: CircleAvatar(
//                               radius: 60,
//                               backgroundColor: Colors.grey[200],
//                               backgroundImage:
//                               profileSetupProvider.profileImage != null
//                                   ? FileImage(profileSetupProvider.profileImage!)
//                                   : null,
//                               child: profileSetupProvider.profileImage == null
//                                   ? Icon(Icons.camera_alt,
//                                   size: 50, color: Colors.grey[800])
//                                   : null,
//                             ),
//                           ),

//                           // Additional form fields
//                           TextFormField(
//                             controller: profileSetupProvider.countryController,
//                             decoration: InputDecoration(
//                               labelText: 'Country',
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter country';
//                               }
//                               return null;
//                             },
//                           ),

//                           TextFormField(
//                             controller: profileSetupProvider.districtController,
//                             decoration: InputDecoration(
//                               labelText: 'District',
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter district';
//                               }
//                               return null;
//                             },
//                           ),

//                           // ID Image Picker
//                           ElevatedButton(
//                             onPressed: () => profileSetupProvider.pickImage(false),
//                             child: Text('Pick ID Image'),
//                           ),

//                           MaterialButton(
//                             minWidth: 300,
//                             onPressed: () async {
//                               if (_formKey.currentState!.validate() &&
//                                   profileSetupProvider.validateForm()) {
//                                 await mainProvider.handleAddressUpdate(
//                                   context: context,
//                                   country: profileSetupProvider.countryController.text.trim(),
//                                   address: profileSetupProvider.addressController.text.trim(),
//                                   district: profileSetupProvider.districtController.text.trim(),
//                                   place: profileSetupProvider.placeController.text.trim(),
//                                   gender: profileSetupProvider.genderController.text.trim(),
//                                   profilePic: profileSetupProvider.profileImage,
//                                   idImage: profileSetupProvider.idImage,
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                         'Please fill all fields and upload both Profile Picture and ID Image'),
//                                   ),
//                                 );
//                               }
//                             },
//                             color: const Color(0xff004CFF),
//                             shape: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: const Text(
//                               'Submit your profile',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../food_app/state providers/set_profile_provider.dart';
import '../providerss/app_provider.dart';

class SetProfilePage extends StatefulWidget {
  @override
  SetProfilePageState createState() => SetProfilePageState();
}

class SetProfilePageState extends State<SetProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize provider data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileSetupProvider =
          Provider.of<ProfileSetupProvider>(context, listen: false);
      final mainProvider = Provider.of<MainProvider>(context, listen: false);

      // Pre-fill email address
      profileSetupProvider.addressController.text =
          mainProvider.emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProfileSetupProvider>(
            builder: (context, profileSetupProvider, _) {
              return Consumer<MainProvider>(
                builder: (context, mainProvider, _) {
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile Image Picker
                          GestureDetector(
                            onTap: () => profileSetupProvider.pickImage(true),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              backgroundImage:
                                  profileSetupProvider.profileImage != null
                                      ? FileImage(
                                          profileSetupProvider.profileImage!)
                                      : null,
                              child: profileSetupProvider.profileImage == null
                                  ? Icon(Icons.camera_alt,
                                      size: 50, color: Colors.grey[800])
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          Text('Profile Picture'),
                          const SizedBox(height: 16.0),

                          // Additional form fields
                          TextFormField(
                            controller: profileSetupProvider.addressController,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          TextFormField(
                            controller: profileSetupProvider.countryController,
                            decoration: InputDecoration(
                              labelText: 'Country',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter country';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          TextFormField(
                            controller: profileSetupProvider.districtController,
                            decoration: InputDecoration(
                              labelText: 'District',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter district';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          TextFormField(
                            controller: profileSetupProvider.placeController,
                            decoration: InputDecoration(
                              labelText: 'Place',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Place';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          TextFormField(
                            controller: profileSetupProvider.genderController,
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Gender';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // ID Image Picker
                          const SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () =>
                                profileSetupProvider.pickImage(false),
                            child: Text(profileSetupProvider.idImage == null
                                ? 'Upload ID Image'
                                : 'Change ID Image'),
                          ),
                          if (profileSetupProvider.idImage != null)
                            Image.file(profileSetupProvider.idImage!,
                                height: 100, width: 100, fit: BoxFit.cover),
                          const SizedBox(height: 24.0),

                          // MaterialButton(
                          //   minWidth: 300,
                          //   onPressed: () async {
                          //     if (_formKey.currentState!.validate() &&
                          //         profileSetupProvider.validateForm()) {
                          //       await mainProvider.handleAddressUpdate(
                          //         context: context,
                          //         country: profileSetupProvider.countryController.text.trim(),
                          //         address: profileSetupProvider.addressController.text.trim(),
                          //         district: profileSetupProvider.districtController.text.trim(),
                          //         place: profileSetupProvider.placeController.text.trim(),
                          //         gender: profileSetupProvider.genderController.text.trim(),
                          //         profilePic: profileSetupProvider.profileImage,
                          //         idImage: profileSetupProvider.idImage,
                          //       );
                          //     } else {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text(
                          //               'Please fill all fields and upload both Profile Picture and ID Image'),
                          //         ),
                          //       );
                          //     }
                          //   },
                          //   color: const Color(0xff004CFF),
                          //   shape: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: const Text(
                          //     'Submit your profile',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),

                          MaterialButton(
                            minWidth: 300,
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  profileSetupProvider.validateForm()) {
                                profileSetupProvider
                                    .setLoading(true); // Start loading
                                try {
                                  await mainProvider.handleAddressUpdate(
                                    context: context,
                                    country: profileSetupProvider
                                        .countryController.text
                                        .trim(),
                                    address: profileSetupProvider
                                        .addressController.text
                                        .trim(),
                                    district: profileSetupProvider
                                        .districtController.text
                                        .trim(),
                                    place: profileSetupProvider
                                        .placeController.text
                                        .trim(),
                                    gender: profileSetupProvider
                                        .genderController.text
                                        .trim(),
                                    profilePic:
                                        profileSetupProvider.profileImage,
                                    idImage: profileSetupProvider.idImage,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Profile updated successfully!')),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to update profile: $e')),
                                  );
                                } finally {
                                  profileSetupProvider
                                      .setLoading(false); // Stop loading
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please fill all fields and upload both Profile Picture and ID Image'),
                                  ),
                                );
                              }
                            },
                            color: const Color(0xff004CFF),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: profileSetupProvider.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Submit your profile',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
