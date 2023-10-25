import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  String? message;
  bool? button;
  String? buttonText;
  Function()? onTap;
  SuccessScreen({super.key, this.message, this.onTap});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool showText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              "https://assets9.lottiefiles.com/packages/lf20_rc5d0f61.json",
              repeat: false,
              onLoaded: (p0) async {
                setState(() {
                  showText = true;
                });
              },
            ),
            showText
                ? Text(
                    widget.message!,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Container(),
          ],
        )),
      ),
    );
  }
}
