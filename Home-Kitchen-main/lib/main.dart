import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/firebase_options.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    FirebaseFirestore.instance
        .collection("driverRequest")
        .doc(inputData!["requestId"])
        .get()
        .then((value) {
      Map<String, dynamic> data = value.data()!;
      if (data["accepted"] == false) {
        sendMessage(
          sharedPreferences!.getString("Token")!,
          "No driver accepted your order.",
          "Now you have to deliver by your own.",
          inputData["context"],
        );
        FirebaseFirestore.instance
            .collection("driverRequest")
            .doc(inputData["requestId"])
            .delete();
      }
    });
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true, // Change it in release build
  );
  sharedPreferences = await SharedPreferences.getInstance();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
