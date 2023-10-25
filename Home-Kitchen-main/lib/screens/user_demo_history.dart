import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/models/userDemo.dart';
import 'package:home_kitchen/screens/user_order_detail.dart';

import '../global/utils/ad_mob_service.dart';
import '../globals.dart';

class UserDemoHistory extends StatefulWidget {
  const UserDemoHistory({super.key});

  @override
  State<UserDemoHistory> createState() => _UserDemoHistoryState();
}

class _UserDemoHistoryState extends State<UserDemoHistory> {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerAd = AdMobsService.createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('orders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    UserDemo userDemo = UserDemo.fromMap(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) =>
                                      UserOrderDetail(userDemo: userDemo))),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userDemo.sellerPhoto)),
                            title: Text(
                                'you have taken demo from seller ${userDemo.sellerName} at ${userDemo.date}'),
                            trailing: Text(userDemo.done ? 'done' : 'not done'),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container();
        },
      ),
      bottomNavigationBar: bannerAd == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 52,
              child: AdWidget(
                ad: bannerAd!,
              ),
            ),
    );
  }
}
