// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDFNgBVOUpKbJ1-W-3k32zozB7DCMSC8Zg',
    appId: '1:1086225396148:web:a0fb89393750ed14e102e1',
    messagingSenderId: '1086225396148',
    projectId: 'homekitchen-ce34d',
    authDomain: 'homekitchen-ce34d.firebaseapp.com',
    storageBucket: 'homekitchen-ce34d.appspot.com',
    measurementId: 'G-ZR1F8EQ9RD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4LiYfJKw6oxlhKFg_bEYeTJRd_J4LcYk',
    appId: '1:1086225396148:android:a515bdd48b7d63dde102e1',
    messagingSenderId: '1086225396148',
    projectId: 'homekitchen-ce34d',
    storageBucket: 'homekitchen-ce34d.appspot.com',
  );
}
