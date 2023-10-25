import 'package:home_kitchen/models/seller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';

SharedPreferences? sharedPreferences;
String? city;
String? area;
double latUser = 0;
double lngUser = 0;
String? completeAddress;
bool? checked = false;
Map<String, dynamic> Monday = {};
Map<String, dynamic> Tuesday = {};
Map<String, dynamic> Wednesday = {};
Map<String, dynamic> Thursday = {};
Map<String, dynamic> Friday = {};
Map<String, dynamic> Saturday = {};
Map<String, dynamic> Sunday = {};
int totalUser = 0;
String sundayNights = '';
List ChipTexts = [];
String price = '';
int click = 0;
Seller? sellerData;
Map<String, dynamic> menu = {
  "Monday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
  },
  "Tuesday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
  },
  "Wednesday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
  },
  "Thursday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
  },
  "Friday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
  },
  "Saturday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add your own": "",
    },
  },
  "Sunday": {
    "day": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add you own": "",
    },
    "night": {
      "Sabji 1": "",
      "Sabji 2": "",
      "Dal": "",
      "Add you own": "",
    },
  },
};
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
