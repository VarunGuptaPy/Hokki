import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_kitchen/global/utils/common_firebase_methods.dart';
import 'package:home_kitchen/globals.dart';
import 'package:uuid/uuid.dart';

class AddHighlightsRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AddHighlightsRepository();
  Future<void> addHighlightsToDatabase(String title,String description,File file,BuildContext context) async{
    String idOfImage = const Uuid().v1();
    String idOfPost = DateTime.now().microsecondsSinceEpoch.toString();
    String downloadUrl = await saveImageToFirebaseStorage(file: file, path: 'posts/$idOfImage', context: context);
    firestore.collection('highlights').doc(idOfPost).set({
      'title':title,
      'description':description,
      'downloadUrl':downloadUrl,
      'name': sharedPreferences!.getString('name'),
      'role': sharedPreferences!.getString('role'),
      'city': sharedPreferences!.getString('city'),
      'uid':FirebaseAuth.instance.currentUser!.uid,
      'profileScreen':sharedPreferences!.getString('photo'),
    });
  }
}