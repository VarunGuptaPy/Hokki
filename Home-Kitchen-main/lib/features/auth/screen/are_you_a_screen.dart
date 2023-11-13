import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/features/auth/screen/name_taking_screen.dart';
import 'package:home_kitchen/features/auth/screen/phone_auth/phone_auth_screen.dart';
import 'package:home_kitchen/global/widgets/RectanglePaineter.dart';
import 'package:home_kitchen/global/widgets/circlePainter.dart';
import 'package:home_kitchen/global/widgets/trianglePainter.dart';

// ignore: must_be_immutable
class AreYouAScreen extends StatefulWidget {
  String? name;
  String? email;
  String? way;
  String? phone;
  UserCredential? userCredential;
  AreYouAScreen(
      {super.key,
      this.name,
      this.email,
      this.phone,
      this.userCredential,
      required this.way});

  @override
  State<AreYouAScreen> createState() => _AreYouAScreenState();
}

class _AreYouAScreenState extends State<AreYouAScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -30,
              right: -70,
              child: Transform.rotate(
                angle: 180 * pi / 180,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: CustomPaint(
                    painter: TrianglePainter(),
                    child: Container(
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              left: -100,
              child: Transform.rotate(
                angle: 180 * pi / 180,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: CustomPaint(
                    painter: CirclePainter(),
                    child: Container(
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                painter: RectanglePainter(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Are you a?",
                    style: TextStyle(
                      fontSize: 70,
                      color: Color(0xff00B965),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => PhoneAuthScreen(
                                  isAuth: false,
                                  name: "areYouAsElLerORNOT",
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: const Color(0xff00B965)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: Text(
                      "Housewife",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (widget.way! == "email") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => PhoneAuthScreen(
                                    name: widget.name,
                                    isAuth: false,
                                  )));
                    } else if (widget.way! == "phone") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => NameTakingScreen(
                                    isPhone: true,
                                    phone: widget.phone!,
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => NameTakingScreen(
                                    isPhone: false,
                                  )));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: const Color(0xff00B965)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: Text(
                      "User",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/sittingMan.png",
                  height: MediaQuery.of(context).size.height * 0.4,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
