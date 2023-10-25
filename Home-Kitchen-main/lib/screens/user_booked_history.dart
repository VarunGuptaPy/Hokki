import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/models/userBook.dart';
import 'package:home_kitchen/models/userDemo.dart';
import 'package:home_kitchen/screens/user_book_detail.dart';

import '../global/utils/ad_mob_service.dart';
import '../globals.dart';

class UserBookedHistory extends StatefulWidget {
  const UserBookedHistory({super.key});

  @override
  State<UserBookedHistory> createState() => _UserBookedHistoryState();
}

class _UserBookedHistoryState extends State<UserBookedHistory> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('book')
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
                          UserBook userDemo = UserBook.fromMap(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20,
                            ),
                            child: Material(
                              elevation: 5,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => UserBookDetail(
                                            userBook: userDemo))),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(userDemo.sellerPhoto)),
                                  title: Text(
                                      'You have taken food from ${userDemo.sellerName} from date ${userDemo.startDate} to ${userDemo.endDate}'),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container();
              },
            ),
          ],
        ),
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
