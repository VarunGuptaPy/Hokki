import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/driver_data_screen.dart';

import '../methods/phoneNumberAuth.dart';

class OtpScreen extends StatefulWidget {
  String? verificationId;
  String? phoneNumber;
  OtpScreen({super.key, this.verificationId, this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool done = false;
  TextEditingController controller0 = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "OTP Verification",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Enter a 6 digit number that has been sent to ${widget.phoneNumber}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InputFocusExample(
                      controller0: controller0,
                      controller1: controller1,
                      controller2: controller2,
                      controller3: controller3,
                      controller4: controller4,
                      controller5: controller5,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2A5A52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ))),
                        child: Text(
                          "Verify OTP",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          verifyOtp(
                              verificationId: widget.verificationId!,
                              UserOtp:
                                  "${controller0.text}${controller1.text}${controller2.text}${controller3.text}${controller4.text}${controller5.text}",
                              context: context,
                              phoneNumber: widget.phoneNumber!);
                          setState(() {
                            done = true;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                )
              ],
            ),
            done
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 5.0,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  )
                : Container(),
            done
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "OTP verification",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                              radius: 80,
                              backgroundColor: Color(0xff009E86),
                              child: Icon(
                                Icons.check,
                                size: 100,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                              "Your Phone Number Has been verified !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff2A5A52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => DriverDataScreen(
                                              way: "phone",
                                              phone: widget.phoneNumber,
                                            )));
                              },
                              child: Text(
                                "Next Step",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  ))
                : Container(),
          ],
        ),
      ),
    )
        // body: Text("Hi"),
        );
  }
}

class InputFocusExample extends StatefulWidget {
  TextEditingController controller0;
  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;
  TextEditingController controller4;
  TextEditingController controller5;
  InputFocusExample({
    super.key,
    required this.controller0,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.controller4,
    required this.controller5,
  });

  @override
  _InputFocusExampleState createState() => _InputFocusExampleState();
}

class _InputFocusExampleState extends State<InputFocusExample> {
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String text = "";

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildInputField(0, widget.controller0),
          buildInputField(1, widget.controller1),
          buildInputField(2, widget.controller2),
          buildInputField(3, widget.controller3),
          buildInputField(4, widget.controller4),
          buildInputField(5, widget.controller5),
        ],
      ),
    );
  }

  Widget buildInputField(int index, TextEditingController controller) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        focusNode: focusNodes[index],
        onChanged: (value) {
          if (value.isNotEmpty && index < focusNodes.length - 1) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          }
        },
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
        ),
      ),
    );
  }
}
