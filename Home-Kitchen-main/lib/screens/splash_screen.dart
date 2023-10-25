import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/features/auth/screen/auth_screen.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';
import 'package:home_kitchen/screens/user_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setState(() {
      checked = false;
    });
    Timer(const Duration(seconds: 4), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => const AuthScreen()))
          : sharedPreferences!.getString('role') == 'user'
              ? Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => UserHomeScreen()))
              : Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'assets/ic_launcher-playstore.png',
        width: MediaQuery.of(context).size.width * 0.5,
      )),
    );
  }
}
