import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/global/widgets/menuWidget.dart';

import '../../globals.dart';
import '../../screens/splash_screen.dart';

class MenuWidgetEdit extends StatefulWidget {
  String day;
  Map<String, dynamic> menu;
  MenuWidgetEdit({required this.day, required this.menu});

  @override
  State<MenuWidgetEdit> createState() => _MenuWidgetEditState();
}

class _MenuWidgetEditState extends State<MenuWidgetEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuWidget(day: widget.day, menu: widget.menu, isSeller: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("items")
                            .doc("item")
                            .update({widget.day: widget.menu});
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c) => SplashScreen()));
                      },
                      child: Text("Done")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
