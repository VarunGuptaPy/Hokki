import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/auth_controlller.dart';

class OtpScreen extends ConsumerStatefulWidget {
  String? verificationId;
  String? phoneNumber;
  OtpScreen({super.key, this.verificationId, this.phoneNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg?w=1060&t=st=1670140985~exp=1670141585~hmac=b860d8e35d9a53ec2d8868200717bd32993c55ed16a77645b4304c91b43de204"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: TextField(
            decoration: const InputDecoration(hintText: 'Enter your otp'),
            onChanged: ((value) {
              if (value.length == 6) {
                ref.watch(authcontrollerProvider).verifyOtp(
                    verificationId: widget.verificationId!,
                    UserOtp: value,
                    context: context,
                    phoneNumber: widget.phoneNumber!);
              }
            }),
          ),
        ),
      ),
      // body: Text("Hi"),
    );
  }
}

class InputFocusExample extends StatefulWidget {
  const InputFocusExample({super.key});

  @override
  _InputFocusExampleState createState() => _InputFocusExampleState();
}

class _InputFocusExampleState extends State<InputFocusExample> {
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

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
        children: List.generate(6, (index) => buildInputField(index)),
      ),
    );
  }

  Widget buildInputField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
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
