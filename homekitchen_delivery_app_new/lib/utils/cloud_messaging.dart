import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../widgets/show_dialog.dart';

void requstPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<String> getToken() async {
  String mToken = '';
  await FirebaseMessaging.instance.getToken().then((value) {
    mToken = value!;
  });
  return mToken;
}

void sendMessage(
    String token, String title, String body, BuildContext context) async {
  try {
    http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA_OgUMbQ:APA91bFlPVKktDMc4G1P4En7AZpsVRxlEaRHs9brQgYKnpwfGrPBd_4WZ7Q3Xmg_-7KVM4gbBdhxcKy4RMV99GUEFGxAD0UvVJZzyGulZlIKY6mDe2swdSvM3l92UxovTAkrGYqlRvUP'
      },
      body: jsonEncode({
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
        "notification": <String, dynamic>{
          "title": title,
          "body": body,
          "android_channle_id": "dbfood",
        },
        "to": token,
      }),
    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
