// ignore: file_names
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_kitchen/features/add_highlights/screens/add_highlights_screen.dart';
import 'package:home_kitchen/features/auth/screen/auth_screen.dart';
import 'package:home_kitchen/features/profile/screen/profile_screen.dart';
import 'package:home_kitchen/features/seller_menu/screens/seller_menu_sceeen.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/screens/seller_data_screen.dart';

import '../global/utils/ad_mob_service.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widget = [
    SellerDataScreen(),
    AddHighlightsScreen(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    // SellerUserUnderMe(),
    // YourDay(),
  ];
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('book')
        .where('daysBetween', isNotEqualTo: [])
        .get()
        .then((value) {
          setState(() {
            totalUser = value.docs.length;
          });
        });
    String encodedMap = sharedPreferences!.getString("sellerData")!;
    Map<String, dynamic> decodeMap = json.decode(encodedMap);
    sellerData = Seller.fromMap(decodeMap);
    bannerAd = AdMobsService.createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Home Kitchen'),
          subtitle: Text("Welcome back, ${sellerData!.name}"),
        ),
        actions: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                GoogleSignIn().signOut();
                setState(() {
                  checked = false;
                  Monday = {};
                  Tuesday = {};
                  Wednesday = {};
                  Thursday = {};
                  Friday = {};
                  Sunday = {};
                  sundayNights = '';
                });
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (c) => AuthScreen()));
              },
              child: Text(
                'log out',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.people),
            //   label: 'Users under you',
            //   backgroundColor: Colors.black,
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.sunny),
            //   label: 'Your day',
            //   backgroundColor: Colors.black,
            // ),
          ],
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
      body: _widget[_selectedIndex],
    );
  }
}
