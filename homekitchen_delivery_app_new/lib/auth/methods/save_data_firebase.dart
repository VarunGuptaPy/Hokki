import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';

import '../../models/Driver.dart';

Future<void> saveDataToFirebase(
  Driver driver,
) async {
  Map<String, dynamic> driverMap = driver.toMap();
  driverMap["profileState"] =
      "Done"; // Changing profile state to done means profile has been created
  await FirebaseFirestore.instance
      .collection("Driver")
      .doc(driverMap["uid"])
      .set(driverMap)
      .then((value) {
    String encodedMap = json.encode(driverMap);
    sharedPreferences!.setString("driverData", encodedMap);
    driverData = Driver.fromMap(driverMap);
  });
}
