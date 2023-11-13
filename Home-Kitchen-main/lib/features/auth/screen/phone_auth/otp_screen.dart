import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_kitchen/features/auth/controller/auth_controlller.dart';

class OtpScreen extends ConsumerStatefulWidget {
  String? verificationId;
  String? phoneNumber;
  OtpScreen({super.key, this.verificationId, this.phoneNumber});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
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
                          ref.watch(authcontrollerProvider).verifyOtp(
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
