import 'dart:math';
import 'dart:ui';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/driver_data_screen.dart';
import 'package:homekitchen_delivery_app_new/auth/phone_auth/otp_screen.dart';

import '../../widgets/circlePainter.dart';
import '../methods/phoneNumberAuth.dart';

class PhoneAuthScreen extends StatefulWidget {
  PhoneAuthScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  Country? countries;
  TextEditingController? phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signWithPhone() {
      if (countries != null && phoneNumberController!.text.trim().isNotEmpty) {
        // signInWithPhone(
        //     phoneNumber:
        //         '+${countries!.phoneCode} ${phoneNumberController!.text}',
        //     context: context);
        signInWithPhone(
            '+${countries!.phoneCode} ${phoneNumberController!.text}', context);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // const SizedBox(
                //   height: 30,
                // ),
                // const Text(
                //   "Your Phone Number",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     color: Color(0xff009E86),
                //     fontSize: 30,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(30.0),
                //   child: Container(
                //     decoration: const BoxDecoration(
                //       color: Color(0xffE8E8E8),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(10),
                //       ),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //                 borderRadius: const BorderRadius.vertical(
                //                     top: Radius.circular(10)),
                //                 color: const Color(0xff00B965),
                //                 border: Border.all(
                //                     width: 4, color: const Color(0xff009E86))),
                //             child: ListTile(
                //               title: const Text(
                //                 "Country/Region",
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               subtitle: countries != null
                //                   ? Text(
                //                       "${countries!.flagEmoji} ${countries!.name}(+${countries!.phoneCode})",
                //                       style: const TextStyle(
                //                           fontSize: 20,
                //                           color: Colors.white,
                //                           fontWeight: FontWeight.bold),
                //                     )
                //                   : const Text(
                //                       "Choose Country code",
                //                       style: TextStyle(
                //                           fontSize: 20,
                //                           color: Colors.white,
                //                           fontWeight: FontWeight.bold),
                //                     ),
                //               trailing: IconButton(
                //                   onPressed: () {
                // showCountryPicker(
                //     context: context,
                //     showPhoneCode: true,
                //     onSelect: (Country country) {
                //       setState(() {
                //         countries = country;
                //       });
                //     });
                //                   },
                //                   icon: const Icon(Icons.arrow_drop_down)),
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 3,
                //           ),
                //           Container(
                //             decoration: BoxDecoration(
                //                 borderRadius: const BorderRadius.vertical(
                //                     bottom: Radius.circular(10)),
                //                 color: const Color(0xff00B965),
                //                 border: Border.all(
                //                     width: 4, color: const Color(0xff009E86))),
                //             child: ListTile(
                //               title: const Text(
                //                 "Enter Your Phone Number",
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               subtitle: TextField(
                //                 decoration:
                //                     InputDecoration(hintText: "99999 99999"),
                //                 style: const TextStyle(
                //                     fontSize: 25,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //                 keyboardType: TextInputType.phone,
                //                 controller: phoneNumberController,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       elevation: 10,
                //       shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.circular(40))),
                //       backgroundColor: const Color(0xff00B965),
                //     ),
                //     onPressed: () {
                //       signWithPhone();
                //     },
                //     child: const Padding(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 90,
                //         vertical: 10,
                //       ),
                //       child: Text(
                //         "Submit",
                //         style: TextStyle(fontSize: 30),
                //       ),
                //     )),
                // Stack(
                //   children: [
                //     Positioned(
                //       left: 10,
                //       child: ImageFiltered(
                //         imageFilter: ImageFilter.blur(
                //           sigmaX: 30,
                //           sigmaY: 30,
                //         ),
                //         child: CustomPaint(
                //           painter: CirclePainter(),
                //           child: Container(
                //             width: 200,
                //             height: 200,
                //           ),
                //         ),
                //       ),
                //     ),
                //     Image.asset(
                //       "assets/images/phoneMan.png",
                //       height: 300,
                //     ),
                //   ],
                // )
                SizedBox(
                  height: MediaQuery.of(context).size.width / 9,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Phone Number",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text("Enter your phone number to verify your phone "),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 10,
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
                    ListTile(
                      title: TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                            hintText: "Enter your Phone Number"),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          signInWithPhone(phoneNumberController!.text, context);
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2A5A52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ))),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}
