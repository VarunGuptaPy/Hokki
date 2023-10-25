import 'dart:math';
import 'dart:ui';

import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_kitchen/features/auth/controller/auth_controlller.dart';
import 'package:home_kitchen/features/auth/screen/seller_informaition_screen.dart';
import 'package:home_kitchen/global/widgets/circlePainter.dart';
import 'package:home_kitchen/global/widgets/trianglePainter.dart';

import '../../repository/auth_repository.dart';

class PhoneAuthScreen extends ConsumerStatefulWidget {
  bool? isAuth;
  String? name;
  PhoneAuthScreen({super.key, this.isAuth, this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends ConsumerState<PhoneAuthScreen> {
  Country? countries;
  TextEditingController? phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void signWithPhone() {
      if (countries != null && phoneNumberController!.text.trim().isNotEmpty) {
        if (widget.isAuth!) {
          ref.read(authcontrollerProvider).signInWithPhone(
              phoneNumber:
                  '+${countries!.phoneCode} ${phoneNumberController!.text}',
              context: context);
        } else {
          if (widget.name! == "areYouAsElLerORNOT") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => SellerInformaitionScreen(
                          phone:
                              '+${countries!.phoneCode} ${phoneNumberController!.text}',
                        )));
          } else {
            ref.watch(authRepositoryProvider).uploadUserDataToFirebase(
                context: context,
                name: widget.name!,
                role: 'user',
                phoneNumber:
                    '${countries!.phoneCode} ${phoneNumberController!.text}');
          }
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Your Phone Number",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff009E86),
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffE8E8E8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              color: const Color(0xff00B965),
                              border: Border.all(
                                  width: 4, color: const Color(0xff009E86))),
                          child: ListTile(
                            title: const Text(
                              "Country/Region",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: countries != null
                                ? Text(
                                    "${countries!.flagEmoji} ${countries!.name}(+${countries!.phoneCode})",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    "Choose Country code",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                            trailing: IconButton(
                                onPressed: () {
                                  showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      onSelect: (Country country) {
                                        setState(() {
                                          countries = country;
                                        });
                                      });
                                },
                                icon: const Icon(Icons.arrow_drop_down)),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(10)),
                              color: const Color(0xff00B965),
                              border: Border.all(
                                  width: 4, color: const Color(0xff009E86))),
                          child: ListTile(
                            title: const Text(
                              "Enter Your Phone Number",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: TextField(
                              decoration:
                                  InputDecoration(hintText: "99999 99999"),
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    backgroundColor: const Color(0xff00B965),
                  ),
                  onPressed: () {
                    signWithPhone();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 10,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 30),
                    ),
                  )),
              Stack(
                children: [
                  Positioned(
                    left: 10,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 30,
                        sigmaY: 30,
                      ),
                      child: CustomPaint(
                        painter: CirclePainter(),
                        child: Container(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/phoneMan.png",
                    height: 300,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         fit: BoxFit.cover,
    //         image: NetworkImage(
    //             "https://img.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg?w=1060&t=st=1670140985~exp=1670141585~hmac=b860d8e35d9a53ec2d8868200717bd32993c55ed16a77645b4304c91b43de204"),
    //       ),
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Text(
    //           'Phone Number Sign In',
    //           style: TextStyle(fontSize: 30, color: Colors.white),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         TextButton(
    //             onPressed: () {
    //               showCountryPicker(
    //                 context: context,
    //                 showPhoneCode:
    //                     true,

    //                 onSelect: (Country country) {
    //                   setState(() {
    //                     countries = country;
    //                   });
    //                 },
    //               );
    //             },
    //             child: Text(
    //               'choose country coder',
    //               style: TextStyle(
    //                 fontSize: 20,
    //               ),
    //             )),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             countries == null
    //                 ? Container()
    //                 : Text('+${countries!.phoneCode}'),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             SizedBox(
    //                 width: MediaQuery.of(context).size.width * 0.8,
    //                 child: TextField(
    //                   decoration:
    //                       InputDecoration(hintText: 'enter your phone Number'),
    //                   controller: phoneNumberController,
    //                 )),
    //           ],
    //         ),
    //         TextButton(
    //           child: Text(
    //             'continue',
    //             style: TextStyle(fontSize: 20),
    //           ),
    //           onPressed: (() {
    //           }),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
