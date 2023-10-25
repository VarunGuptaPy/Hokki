import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/ask_for_login_and_signUp.dart';
import 'package:homekitchen_delivery_app_new/auth/auth_screen.dart';
import 'package:homekitchen_delivery_app_new/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // setState(() {
    //   checked = false;
    // });
    Timer(const Duration(seconds: 4), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => AskForLoginAndSginUp()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => HomeScreen()));
      // Navigator.push(context, MaterialPageRoute(builder: (c) => AuthScreen()));
      //   FirebaseAuth.instance.currentUser == null
      //       ? Navigator.pushReplacement(
      //           context, MaterialPageRoute(builder: (c) => const AuthScreen()))
      //       : sharedPreferences!.getString('role') == 'user'
      //           ? Navigator.pushReplacement(
      //               context, MaterialPageRoute(builder: (c) => UserHomeScreen()))
      //           : Navigator.pushReplacement(context,
      //               MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        'assets/app_logo.png',
        width: MediaQuery.of(context).size.width * 0.5,
      )),
    );
  }
}
