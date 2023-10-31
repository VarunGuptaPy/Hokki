// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/driver_data_screen.dart';
import 'package:homekitchen_delivery_app_new/models/Driver.dart';
import 'package:homekitchen_delivery_app_new/screens/home_screen.dart';

import '../../globals.dart';
import '../../widgets/show_dialog.dart';

Future<void> logInWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  try {
    // ignore: unused_local_variable
    UserCredential credential = await auth!
        .signInWithEmailAndPassword(email: email, password: password);
    await firestore!
        .collection('Driver')
        .doc(auth!.currentUser!.uid)
        .get()
        .then((value) async {
      Map<String, dynamic> data = value.data()!;
      if (value.exists) {
        final String stringMap = json.encode(data);
        sharedPreferences!.setString("driverData", stringMap);
        driverData = Driver.fromMap(data);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      } else {
        auth!.signOut();
        showSnackBar(context, "This account is not of driver.");
      }
    });
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

Future<void> registerWithEmailAndPassword(
    BuildContext context, String email, String password, String name) async {
  try {
    UserCredential credential = await auth!
        .createUserWithEmailAndPassword(email: email, password: password);
    // ignore: use_build_context_synchronously
    FirebaseFirestore.instance
        .collection("Driver")
        .doc(credential.user!.uid)
        .set({
      "profileState": "underProcess",
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (c) => DriverDataScreen(
                  way: "email",
                  name: name,
                  email: email,
                )));
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
