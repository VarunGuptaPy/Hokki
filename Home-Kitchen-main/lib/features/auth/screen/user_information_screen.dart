// import 'dart:io';

// import 'package:country_picker/country_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:home_kitchen/features/auth/controller/auth_controlller.dart';
// import 'package:home_kitchen/features/auth/repository/auth_repository.dart';
// import 'package:home_kitchen/global/utils/pick_image.dart';

// class UserInformationScreen extends ConsumerStatefulWidget {
//   UserCredential credential;
//   UserInformationScreen({super.key, required this.credential});

//   @override
//   ConsumerState<UserInformationScreen> createState() =>
//       _UserInformationScreenState();
// }

// class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
//   List<String> roles = ['user', 'seller'];
//   String selectedItem = 'user';
//   TextEditingController locationController = TextEditingController();
//   TextEditingController? nameController = TextEditingController();
//   TextEditingController? phoneNumberController = TextEditingController();
//   Country? countries = Country.tryParse('india');
//   List positions = [];
//   Position? position;
//   List<Placemark>? placemarks;
//   String completeAddress = "";
//   getCurrentLocation() async {
//     Placemark? placemark;
//     await Geolocator.requestPermission().whenComplete(() async {
//       Position newPos = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       position = newPos;
//       placemarks = await placemarkFromCoordinates(
//           position!.latitude, position!.longitude);
//       Placemark pMark = placemarks![0];
//       completeAddress =
//           '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';
//       locationController.text = completeAddress;
//       placemark = pMark;
//     });
//     return [placemark, position!.latitude, position!.longitude];
//   }

//   File? file;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: NetworkImage(
//                   "https://img.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg?w=1060&t=st=1670140985~exp=1670141585~hmac=b860d8e35d9a53ec2d8868200717bd32993c55ed16a77645b4304c91b43de204"),
//               fit: BoxFit.cover),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               'Details',
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             selectedItem == 'seller'
//                 ? file == null
//                     ? GestureDetector(
//                         onTap: () async {
//                           file = await pickImage();
//                           setState(() {
//                             file;
//                           });
//                         },
//                         child: CircleAvatar(
//                           radius: 64,
//                           backgroundImage: NetworkImage(
//                               'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
//                         ))
//                     : CircleAvatar(radius: 64,backgroundImage: FileImage(file!),)
//                 : Container(),
//             ListTile(
//               title: TextField(
//                 controller: nameController,
//               ),
//               leading: const Text('Enter your name'),
//             ),
//             ListTile(
//               title: TextField(
//                 controller: phoneNumberController,
//                 decoration: InputDecoration(hintText: 'enter you phone number'),
//               ),
//               leading: GestureDetector(
//                 child: Text(
//                   "+${countries!.phoneCode} ⬇",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 onTap: () {
//                   showCountryPicker(
//                     context: context,
//                     showPhoneCode:
//                         true, // optional. Shows phone code before the country name.
//                     onSelect: (Country country) {
//                       setState(() {
//                         countries = country;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             ListTile(
//               leading: const Text('Enter your role'),
//               title: DropdownButton<String>(
//                 value: selectedItem,
//                 items: roles
//                     .map((e) => DropdownMenuItem(
//                           child: Text(e),
//                           value: e,
//                         ))
//                     .toList(),
//                 onChanged: (item) {
//                   setState(() {
//                     selectedItem = item!;
//                   });
//                 },
//               ),
//             ),
//             selectedItem == 'seller'
//                 ? ListTile(
//                     leading: Text('enter your address'),
//                     title: TextField(
//                       controller: locationController,
//                     ),
//                   )
//                 : Container(),
//             selectedItem == 'seller'
//                 ? ElevatedButton(
//                     onPressed: () async {
//                       positions = await getCurrentLocation();
//                     },
//                     child: Text('get your current location'))
//                 : Container(),
//             TextButton(
//               onPressed: () async {
//                 if (locationController.text.isNotEmpty &&
//                     nameController!.text.isNotEmpty &&
//                     phoneNumberController!.text.isNotEmpty &&
//                     countries != null &&
//                     selectedItem == 'seller') {
//                   ref.watch(authRepositoryProvider).uploadSellerDataToFirebase(
//                       context: context,
//                       lat: positions[1],
//                       lng: positions[2],
//                       credential: widget.credential,
//                       role: selectedItem,
//                       country: countries!,
//                       phoneNumber: phoneNumberController!.text,
//                       name: nameController!.text,
//                       address: locationController.text,
//                       placemark: positions[0],
//                       profilePic: file);
//                 } else if (nameController!.text.isNotEmpty &&
//                     phoneNumberController!.text.isNotEmpty &&
//                     selectedItem == 'user') {
//                   ref.watch(authRepositoryProvider).uploadUserDataToFirebase(
//                       context: context,
//                       name: nameController!.text,
//                       role: 'user',
//                       phoneNumber:
//                           '${countries!.phoneCode}${phoneNumberController!.text}');
//                 }
//               },
//               child: const Text(
//                 'Submit',
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
