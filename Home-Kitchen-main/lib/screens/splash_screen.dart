import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/features/auth/screen/are_you_a_screen.dart';
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
  whereToNavigate() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      var data = value.data()!;
      if (data["profileState"] == "underProcess") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (c) => AreYouAScreen(way: "google")));
      } else {
        if (sharedPreferences!.getString('role') == 'user') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
        }
      }
    });
  }

  @override
  void initState() {
    setState(() {
      checked = false;
    });
    Timer(const Duration(seconds: 4), () {
      FirebaseAuth.instance.currentUser == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => const AuthScreen()))
          : whereToNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff016b39),
      body: Center(
          child: Image.asset(
        'assets/ic_launcher-playstore.png',
        width: MediaQuery.of(context).size.width * 0.5,
      )),
    );
  }
}
