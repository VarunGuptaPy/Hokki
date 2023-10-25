import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/show_dialog.dart';

Future<String> saveImageToFirebaseStorage(
    {required File? file,
    required String path,
    required BuildContext context}) async {
  String downloadUrl = '';
  try {
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(path).putFile(file!);
    final upload = await uploadTask;
    downloadUrl = await upload.ref.getDownloadURL();
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return downloadUrl;
}
