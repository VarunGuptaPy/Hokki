import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homekitchen_delivery_app_new/auth/driver_data_screen.dart';

import '../../globals.dart';
import '../../screens/home_screen.dart';
import '../../widgets/show_dialog.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await auth!.signInWithCredential(credential);
    if (userCredential.credential != null) {
      if (userCredential.additionalUserInfo!.isNewUser) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (c) => DriverDataScreen(
                      way: "google",
                    )));
      } else {
        await firestore!
            .collection('Driver')
            .doc(auth!.currentUser!.uid)
            .get()
            .then((value) async {
          Map<String, dynamic> data = value.data()!;
          if (value.exists) {
            final String stringMap = json.encode(data);
            sharedPreferences!.setString("driverData", stringMap);
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => HomeScreen()));
          } else {
            auth!.signOut();
            showSnackBar(context, "This account is not of driver.");
          }
        });
        // await firestore!
        //     .collection('users')
        //     .doc(auth!.currentUser!.uid)
        //     .get()
        //     .then((value) async {
        //   if (value.data()!['role'] == 'seller') {
        //     sharedPreferences!.setString('name', value.data()!['name']);
        //     sharedPreferences!.setInt('maxUser', value.data()!["maxUser"]);
        //     sharedPreferences!.setString('role', value.data()!['role']);
        //     sharedPreferences!
        //         .setString('phoneNumber', value.data()!['phoneNumber']);
        //     sharedPreferences!.setString('city', value.data()!['city']);
        //     sharedPreferences!.setDouble('lat', value.data()!['lat']);
        //     sharedPreferences!.setDouble('lng', value.data()!['lng']);
        //     sharedPreferences!
        //         .setString('photo', value.data()!['profilePic']);
        //     requstPermission();
        //     String Token = await getToken();
        //     if (value.data()!['Token'] == Token) {
        //       sharedPreferences!.setString('Token', value.data()!['Token']);
        //     } else {
        //       firestore!
        //           .collection('users')
        //           .doc(auth!.currentUser!.uid)
        //           .update({
        //         'Token': Token,
        //       });
        //     }
        //     // Navigator.pushReplacement(context,
        //     //     MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
        //   } else {
        //     sharedPreferences!.setString('name', value.data()!['name']);
        //     sharedPreferences!.setString('role', value.data()!['role']);
        //     sharedPreferences!
        //         .setString('phoneNumber', value.data()!['phoneNumber']);
        //     requstPermission();
        //     String Token = await getToken();
        //     if (value.data()!['Token'] == Token) {
        //       sharedPreferences!.setString('Token', value.data()!['Token']);
        //     } else {
        //       firestore!
        //           .collection('users')
        //           .doc(auth!.currentUser!.uid)
        //           .update({
        //         'Token': Token,
        //       });
        //     }
        //     // Navigator.pushReplacement(
        //     //     context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
        //   }
        // });
      }
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
