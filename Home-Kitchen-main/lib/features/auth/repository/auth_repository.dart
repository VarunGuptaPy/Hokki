// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_kitchen/features/auth/screen/are_you_a_screen.dart';
import 'package:home_kitchen/features/auth/screen/phone_auth/otp_screen.dart';
import 'package:home_kitchen/features/seller_menu/screens/make_your_menu.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';
import 'package:home_kitchen/global/utils/common_firebase_methods.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/models/user.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';
import 'package:home_kitchen/screens/user_home_screen.dart';

final authRepositoryProvider = Provider(((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
}));

class AuthRepository {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
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
          await auth.signInWithCredential(credential);
      if (userCredential.credential != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (c) => AreYouAScreen(
                        way: "google",
                        userCredential: userCredential,
                      )));
        } else {
          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .get()
              .then((value) async {
            if (value.data()!['role'] == 'seller') {
              sharedPreferences!.setString('name', value.data()!['name']);
              sharedPreferences!.setInt('maxUser', value.data()!["maxUser"]);
              sharedPreferences!.setString('role', value.data()!['role']);
              sharedPreferences!
                  .setString('phoneNumber', value.data()!['phoneNumber']);
              sharedPreferences!.setString('city', value.data()!['city']);
              sharedPreferences!.setDouble('lat', value.data()!['lat']);
              sharedPreferences!.setDouble('lng', value.data()!['lng']);
              sharedPreferences!
                  .setString('photo', value.data()!['profilePic']);
              sellerData = Seller.fromMap(value.data()!);
              String encodedMap = json.encode(sellerData!.toMap());
              sharedPreferences!.setString("sellerData", encodedMap);
              requstPermission();
              String Token = await getToken();
              if (value.data()!['Token'] == Token) {
                sharedPreferences!.setString('Token', value.data()!['Token']);
              } else {
                firestore
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .update({
                  'Token': Token,
                });
              }
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
            } else {
              sharedPreferences!.setString('name', value.data()!['name']);
              sharedPreferences!.setString('role', value.data()!['role']);
              sharedPreferences!
                  .setString('phoneNumber', value.data()!['phoneNumber']);
              requstPermission();
              String Token = await getToken();
              if (value.data()!['Token'] == Token) {
                sharedPreferences!.setString('Token', value.data()!['Token']);
              } else {
                firestore
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .update({
                  'Token': Token,
                });
              }
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
            }
          });
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> logInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.data()!['role'] == 'seller') {
          sharedPreferences!.setString('name', value.data()!['name']);
          sharedPreferences!.setString('role', value.data()!['role']);
          sharedPreferences!.setInt('maxUser', value.data()!["maxUser"]);
          sharedPreferences!.setString('uid', value.data()!["uid"]);
          sharedPreferences!
              .setString('phoneNumber', value.data()!['phoneNumber']);
          sharedPreferences!.setString('city', value.data()!['city']);
          sharedPreferences!.setString('photo', value.data()!['profilePic']);
          sharedPreferences!.setDouble('lat', value.data()!['lat']);
          sharedPreferences!.setDouble('lng', value.data()!['lng']);
          sellerData = Seller.fromMap(value.data()!);
          String encodedMap = json.encode(sellerData!.toMap());
          sharedPreferences!.setString("sellerData", encodedMap);
          requstPermission();
          String Token = await getToken();
          if (value.data()!['Token'] == Token) {
            sharedPreferences!.setString('Token', value.data()!['Token']);
          } else {
            firestore.collection('users').doc(auth.currentUser!.uid).update({
              'Token': Token,
            });
          }
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
        } else {
          sharedPreferences!.setString('name', value.data()!['name']);
          sharedPreferences!.setString('role', value.data()!['role']);
          sharedPreferences!
              .setString('phoneNumber', value.data()!['phoneNumber']);
          requstPermission();
          String Token = await getToken();
          if (value.data()!['Token'] == Token) {
            sharedPreferences!.setString('Token', value.data()!['Token']);
          } else {
            firestore.collection('users').doc(auth.currentUser!.uid).update({
              'Token': Token,
            });
          }
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
        }
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> registerWithEmailAndPassword(
      BuildContext context, String email, String password, String name) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (c) => AreYouAScreen(
                    way: "email",
                    name: name,
                    email: email,
                    userCredential: credential,
                  )));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInWithPhone(String phoneNumber, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
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
          await auth.signInWithCredential(phoneAuthCredential);
      if (credential.additionalUserInfo!.isNewUser) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (c) => AreYouAScreen(
                      way: "phone",
                      phone: phoneNumber,
                      userCredential: credential,
                    )));
      } else {
        await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) async {
          if (value.data()!['role'] == 'seller') {
            sharedPreferences!.setString('name', value.data()!['name']);
            sharedPreferences!.setString('role', value.data()!['role']);
            sharedPreferences!
                .setString('phoneNumber', value.data()!['phoneNumber']);
            sharedPreferences!.setString('phoneNumber', value.data()!['city']);
            sharedPreferences!.setString('photo', value.data()!['profilePic']);
            sharedPreferences!.setDouble('lat', value.data()!['lat']);
            sharedPreferences!.setDouble('lng', value.data()!['lng']);
            sharedPreferences!.setInt('maxUser', value.data()!["maxUser"]);
            sellerData = Seller.fromMap(value.data()!);
            String encodedMap = json.encode(sellerData!.toMap());
            sharedPreferences!.setString("sellerData", encodedMap);
            requstPermission();
            String Token = await getToken();
            if (value.data()!['Token'] == Token) {
              sharedPreferences!.setString('Token', value.data()!['Token']);
            } else {
              firestore.collection('users').doc(auth.currentUser!.uid).update({
                'Token': Token,
              });
            }
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (c) => const SellerHomeScreen()));
          } else {
            sharedPreferences!.setString('name', value.data()!['name']);
            sharedPreferences!.setString('role', value.data()!['role']);
            sharedPreferences!
                .setString('phoneNumber', value.data()!['phoneNumber']);
            requstPermission();
            String Token = await getToken();
            if (value.data()!['Token'] == Token) {
              sharedPreferences!.setString('Token', value.data()!['Token']);
            } else {
              firestore.collection('users').doc(auth.currentUser!.uid).update({
                'Token': Token,
              });
            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
          }
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void uploadSellerDataToFirebase(
      {File? profilePic,
      required BuildContext context,
      required double lat,
      required double lng,
      required String role,
      required String phoneNumber,
      required String name,
      required String address,
      required Placemark placemark}) async {
    String uid = auth.currentUser!.uid;
    String downloadUrl =
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png';
    if (profilePic != null) {
      downloadUrl = await saveImageToFirebaseStorage(
          file: profilePic, path: 'propic/$uid', context: context);
    }
    requstPermission();
    String Token = await getToken();
    Seller seller = Seller(
      Token: Token,
      maxUser: 2,
      userUnderMe: 0,
      active: false,
      profilePic: downloadUrl,
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      city: placemark.locality!,
      area: placemark.subLocality!,
      lat: lat,
      lng: lng,
      role: role,
      uid: auth.currentUser!.uid,
      myTotalEarning: 0,
      unWidraw: 0,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(seller.toMap());
    sharedPreferences!.setString('name', seller.name);
    sharedPreferences!.setString("uid", FirebaseAuth.instance.currentUser!.uid);
    sharedPreferences!.setString('role', seller.role);
    sharedPreferences!.setString('phoneNumber', seller.phoneNumber);
    sharedPreferences!.setString('city', seller.city);
    sharedPreferences!.setString('photo', seller.profilePic);
    sharedPreferences!.setString("Token", Token);
    sharedPreferences!.setDouble('lat', seller.lat);
    sharedPreferences!.setInt('maxUser', seller.maxUser);
    sharedPreferences!.setDouble('lng', seller.lng);
    String encodedMap = json.encode(seller.toMap());
    sharedPreferences!.setString("sellerData", encodedMap);
    sellerData = seller;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => const MakeYourMenu()));
  }

  void uploadUserDataToFirebase(
      {required BuildContext context,
      required String name,
      required String role,
      required String phoneNumber}) async {
    requstPermission();
    String Token = await getToken();

    try {
      Users user = Users(
          uid: auth.currentUser!.uid,
          name: name,
          role: role,
          phoneNumber: phoneNumber,
          token: Token);
      firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(user.toMap());
      sharedPreferences!.setString('name', name);
      sharedPreferences!.setString('role', role);
      sharedPreferences!.setString('phoneNumber', phoneNumber);
      sharedPreferences!.setString('Token', Token);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => UserHomeScreen())));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
