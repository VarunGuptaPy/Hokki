import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homekitchen_delivery_app_new/auth/methods/save_data_firebase.dart';
import 'package:homekitchen_delivery_app_new/models/Driver.dart';
import 'package:homekitchen_delivery_app_new/screens/home_screen.dart';

import '../utils/common_firebase.dart';
import '../utils/pick_image.dart';

// ignore: must_be_immutable
class DriverDataScreen extends StatefulWidget {
  String? name;
  String? email;
  UserCredential? userCredential;
  String? way;
  String? phone;
  DriverDataScreen({super.key, this.name, this.email, this.way, this.phone});

  @override
  State<DriverDataScreen> createState() => _DriverDataScreenState();
}

class _DriverDataScreenState extends State<DriverDataScreen> {
  List positions = [];
  Position? position;
  Country? countries;
  TextEditingController locationController = TextEditingController();
  List<Placemark>? placemarks;
  String completeAddress = "";
  String? phoneNumber;
  getCurrentLocation() async {
    Placemark? placemark;
    await Geolocator.requestPermission().whenComplete(() async {
      Position newPos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPos;
      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMark = placemarks![0];
      completeAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';
      locationController.text = completeAddress;
      placemark = pMark;
    });
    return [placemark, position!.latitude, position!.longitude];
  }

  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController? nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 20,
                // ),
                // Center(
                //   child: CircleAvatar(
                //     radius: 68,
                //     backgroundColor: const Color(0xff00B965),
                //     child: file == null
                //         ? GestureDetector(
                //             onTap: () async {
                //               file = await pickImage();
                //               setState(() {
                //                 file;
                //               });
                //             },
                //             child: const CircleAvatar(
                //               radius: 64,
                //               backgroundImage: NetworkImage(
                //                   'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                //             ))
                //         : CircleAvatar(
                //             radius: 64,
                //             backgroundImage: FileImage(file!),
                //           ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(30.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: const BorderRadius.all(Radius.circular(40)),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.black.withOpacity(0.5),
                //             blurRadius: 5,
                //             offset: const Offset(5, 5)),
                //       ],
                //     ),
                //     padding: const EdgeInsets.all(30),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           "Driver Name",
                //           style: TextStyle(
                //               fontSize: 20, fontWeight: FontWeight.bold),
                //         ),
                //         TextField(
                //           controller: nameController,
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             const Text(
                //               "Address",
                //               style: TextStyle(
                //                   fontSize: 20, fontWeight: FontWeight.bold),
                //             ),
                //             IconButton(
                //                 onPressed: () async {
                //                   positions = await getCurrentLocation();
                //                 },
                //                 icon: const Icon(Icons.location_on))
                //           ],
                //         ),
                //         TextField(
                //           controller: locationController,
                //         ),
                //         const SizedBox(
                //           height: 20,
                //         ),
                //         Container(
                //           decoration: const BoxDecoration(
                //             color: Color(0xffE8E8E8),
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(10),
                //             ),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               children: [
                //                 Container(
                //                   decoration: BoxDecoration(
                //                       borderRadius: const BorderRadius.vertical(
                //                           top: Radius.circular(10)),
                //                       color: const Color(0xff00B965),
                //                       border: Border.all(
                //                           width: 4,
                //                           color: const Color(0xff009E86))),
                //                   child: ListTile(
                //                     title: const Text(
                //                       "Country/Region",
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                     subtitle: countries != null
                //                         ? Text(
                //                             "${countries!.flagEmoji} ${countries!.name}(+${countries!.phoneCode})",
                //                             style: const TextStyle(
                //                                 fontSize: 20,
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold),
                //                           )
                //                         : const Text(
                //                             "Choose Country code",
                //                             style: TextStyle(
                //                                 fontSize: 20,
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold),
                //                           ),
                //                     trailing: IconButton(
                //                         onPressed: () {
                //                           showCountryPicker(
                //                               context: context,
                //                               showPhoneCode: true,
                //                               onSelect: (Country country) {
                //                                 setState(() {
                //                                   countries = country;
                //                                 });
                //                               });
                //                         },
                //                         icon: const Icon(Icons.arrow_drop_down)),
                //                   ),
                //                 ),
                //                 const SizedBox(
                //                   height: 3,
                //                 ),
                //                 Container(
                //                   decoration: BoxDecoration(
                //                       borderRadius: const BorderRadius.vertical(
                //                           bottom: Radius.circular(10)),
                //                       color: const Color(0xff00B965),
                //                       border: Border.all(
                //                           width: 4,
                //                           color: const Color(0xff009E86))),
                //                   child: ListTile(
                //                     title: const Text(
                //                       "Enter Your Phone Number",
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //                     subtitle: TextField(
                //                       decoration: const InputDecoration(
                //                           hintText: "99999 99999"),
                //                       style: const TextStyle(
                //                           fontSize: 25,
                //                           color: Colors.white,
                //                           fontWeight: FontWeight.bold),
                //                       keyboardType: TextInputType.phone,
                //                       controller: phoneNumberController,
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         const SizedBox(
                //           height: 20,
                //         ),
                //         Center(
                //           child: ClipRRect(
                //             borderRadius:
                //                 const BorderRadius.all(Radius.circular(20)),
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                 elevation: 30,
                //                 backgroundColor: const Color(0xff00B965),
                //               ),
                //               onPressed: () async {
                //                 String? imageUrl;
                //                 file == null
                //                     ? imageUrl =
                //                         'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'
                //                     : imageUrl = await saveImageToFirebaseStorage(
                //                         context: context,
                //                         file: file,
                //                         path: file!.path);
                //                 Placemark placemark = positions[0];
                //                 Driver driver = Driver(
                //                     name: nameController!.text,
                //                     role: "driver",
                //                     phoneNumber:
                //                         '+${countries!.phoneCode} ${phoneNumberController!.text}',
                //                     address: locationController.text,
                //                     city: placemark.locality!,
                //                     area: placemark.subLocality!,
                //                     lat: positions[1],
                //                     lng: positions[2],
                //                     profilePic: imageUrl,
                //                     uid: FirebaseAuth.instance.currentUser!.uid);
                //                 await saveDataToFirebase(driver);
                //                 // ignore: use_build_context_synchronously
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (c) => const HomeScreen()));
                //               },
                //               child: const Padding(
                //                 padding: EdgeInsets.symmetric(
                //                     vertical: 8.0, horizontal: 30),
                //                 child: Text(
                //                   "Submit",
                //                   style: TextStyle(fontSize: 25),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Driver Information",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: file == null
                      ? GestureDetector(
                          onTap: () async {
                            file = await pickImage();
                            setState(() {
                              file;
                            });
                          },
                          child: const CircleAvatar(
                            radius: 90,
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                          ))
                      : CircleAvatar(
                          radius: 90,
                          backgroundImage: FileImage(file!),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: "Driver Name"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: TextField(
                    enabled: false,
                    controller: locationController,
                    decoration: InputDecoration(hintText: "Address"),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () async {
                      positions = await getCurrentLocation();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: TextField(
                    enabled: false,
                    controller: countryController,
                    decoration: InputDecoration(
                      hintText: "Country/Region",
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      print("clicked");
                      showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              countries = country;
                              countryController.text =
                                  "${countries!.flagEmoji} ${countries!.name}(+${countries!.phoneCode})";
                            });
                          });
                    },
                    child: Icon(
                      Icons.arrow_drop_down,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(hintText: "Enter Phone Number"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                      "We will not share your information with anyon else it will be safe with only us"),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? imageUrl;
                        file == null
                            ? imageUrl =
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'
                            : imageUrl = await saveImageToFirebaseStorage(
                                context: context, file: file, path: file!.path);
                        Placemark placemark = positions[0];
                        Driver driver = Driver(
                          name: nameController!.text,
                          role: "driver",
                          phoneNumber:
                              '+${countries!.phoneCode} ${phoneNumberController!.text}',
                          address: locationController.text,
                          city: placemark.locality!,
                          area: placemark.subLocality!,
                          lat: positions[1],
                          lng: positions[2],
                          profilePic: imageUrl,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          totalDeliveries: 0,
                          totalIncome: 0,
                        );
                        await saveDataToFirebase(driver);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const HomeScreen()));
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2A5A52),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
