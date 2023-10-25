import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homekitchen_delivery_app_new/models/Driver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth? auth;
FirebaseFirestore? firestore;
Driver? driverData;
Placemark? placemark;
List positions = [];
Position? position;
List<Placemark>? placemarks;
getCurrentLocation() async {
  await Geolocator.requestPermission().whenComplete(() async {
    Position newPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = newPos;
    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark pMark = placemarks![0];
    placemark = pMark;
  });
  return [placemark, position!.latitude, position!.longitude];
}

Map<String, dynamic> findBestMatch(String base, List<dynamic> targets) {
  var ratings = [];
  var highest = 0.0;
  var bestMatchIndex = 0;

  for (var i = 0; i < targets.length; i++) {
    var currentRating = base.similarityTo(targets[i]);
    ratings.add({"target": targets[i], "rating": currentRating});

    if (currentRating > highest) {
      highest = currentRating;
      bestMatchIndex = i;
    }
  }

  var bestMatch = ratings[bestMatchIndex];

  return {
    "ratings": ratings,
    "bestMatch": bestMatch,
  };
}
