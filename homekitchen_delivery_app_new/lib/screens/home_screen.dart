import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/auth_screen.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';
import 'package:homekitchen_delivery_app_new/models/Driver.dart';
import 'package:homekitchen_delivery_app_new/screens/Success_screen.dart';
import 'package:homekitchen_delivery_app_new/screens/bookers_near_me.dart';
import 'package:homekitchen_delivery_app_new/screens/demo_near_me.dart';
import 'package:homekitchen_delivery_app_new/screens/details_screeen.dart';
import 'package:homekitchen_delivery_app_new/screens/my_day.dart';
import 'package:homekitchen_delivery_app_new/widgets/slider_dialog.dart';

import '../auth/ask_for_login_and_signUp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    String encodedMap = sharedPreferences!.getString("driverData")!;
    Map<String, dynamic> decodeMap = json.decode(encodedMap);
    print(FirebaseAuth.instance.currentUser!.uid);
    driverData = Driver.fromMap(decodeMap);
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      // SafeArea(
      //   child: Center(
      //     child: ElevatedButton(
      //       child: Text("Log Out"),
      //       onPressed: () {
      //         FirebaseAuth.instance.signOut();
      //         Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (c) => AskForLoginAndSginUp()));
      //       },
      //     ),
      //   ),
      // ),
      DetailsScreen(
        selectedIndex: _selectedIndex,
      ),
      const DemoNearMe(),
      BookersNearME(),
      MyDay()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Icon(
                      Icons.home,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.photo_outlined,
                      color: Colors.black,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Icon(
                      Icons.near_me,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.near_me_outlined,
                      color: Colors.black,
                    ),
              label: 'Demo Near me',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? Icon(
                      Icons.shopping_bag,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
              label: 'Bookers Near me',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? Icon(
                      Icons.wb_sunny,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.wb_sunny_outlined,
                      color: Colors.black,
                    ),
              label: 'My day',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
      body: screen[_selectedIndex],
    );
  }
}
