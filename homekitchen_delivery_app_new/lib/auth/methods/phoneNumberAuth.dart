import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/driver_data_screen.dart';

import '../../globals.dart';
import '../../screens/home_screen.dart';
import '../../utils/cloud_messaging.dart';
import '../../widgets/show_dialog.dart';
import '../phone_auth/otp_screen.dart';

void signInWithPhone(String phoneNumber, BuildContext context) async {
  try {
    await auth!.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await auth!.signInWithCredential(phoneAuthCredential);
        },
        codeSent: (String verificationId, int? resentToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String string) {},
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          throw (firebaseAuthException);
        });
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}

void verifyOtp(
    {required String verificationId,
    required String UserOtp,
    required BuildContext context,
    required String phoneNumber}) async {
  try {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: UserOtp);
    UserCredential credential =
        await auth!.signInWithCredential(phoneAuthCredential);
    if (credential.additionalUserInfo!.isNewUser) {
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
      // await firestore
      //     .collection('users')
      //     .doc(auth.currentUser!.uid)
      //     .get()
      //     .then((value) async {
      //   if (value.data()!['role'] == 'seller') {
      //     sharedPreferences!.setString('name', value.data()!['name']);
      //     sharedPreferences!.setString('role', value.data()!['role']);
      //     sharedPreferences!
      //         .setString('phoneNumber', value.data()!['phoneNumber']);
      //     sharedPreferences!.setString('phoneNumber', value.data()!['city']);
      //     sharedPreferences!.setString('photo', value.data()!['profilePic']);
      //     sharedPreferences!.setDouble('lat', value.data()!['lat']);
      //     sharedPreferences!.setDouble('lng', value.data()!['lng']);
      //     sharedPreferences!.setInt('maxUser', value.data()!["maxUser"]);
      //     requstPermission();
      //     String Token = await getToken();
      //     if (value.data()!['Token'] == Token) {
      //       sharedPreferences!.setString('Token', value.data()!['Token']);
      //     } else {
      //       firestore!.collection('users').doc(auth!.currentUser!.uid).update({
      //         'Token': Token,
      //       });
      //     }
      //     Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
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
      //       firestore.collection('users').doc(auth.currentUser!.uid).update({
      //         'Token': Token,
      //       });
      //     }
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
      //   }
      // });
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
