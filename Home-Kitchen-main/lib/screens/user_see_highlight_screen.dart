import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/posts.dart';
import 'package:http/http.dart';

import '../global/utils/ad_mob_service.dart';

class UserSeeHighLightScrenn extends StatefulWidget {
  const UserSeeHighLightScrenn({super.key});

  @override
  State<UserSeeHighLightScrenn> createState() => _UserSeeHighLightScrennState();
}

class _UserSeeHighLightScrennState extends State<UserSeeHighLightScrenn> {
  BannerAd? bannerAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerAd = AdMobsService.createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('highlights')
            .where('city', isEqualTo: city)
            .limit(100)
            .get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    Posts posts = Posts.fromMap(snapshot.data!.docs[index]
                        .data()! as Map<String, dynamic>);
                    if (index % 2 == 0) {
                      BannerAd? bannerAds;
                      bannerAds = AdMobsService.createBannerAd();
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.black)),
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  Image.network(
                                    posts.downloadUrl,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          gradient: RadialGradient(colors: [
                                            Colors.grey,
                                            Colors.blueGrey
                                          ])),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                              radius: 12,
                                              backgroundImage: NetworkImage(
                                                  posts.profilePic)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                posts.name,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    posts.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    posts.description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              bannerAds == null
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      height: 52,
                                      child: AdWidget(
                                        ad: bannerAds,
                                      ),
                                    )
                            ],
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Stack(
                              children: [
                                Image.network(
                                  posts.downloadUrl,
                                  width: double.infinity,
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        gradient: RadialGradient(colors: [
                                          Colors.grey,
                                          Colors.blueGrey
                                        ])),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                            radius: 12,
                                            backgroundImage:
                                                NetworkImage(posts.profilePic)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              posts.name,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ListTile(
                              leading: Text(
                                posts.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              title: Text(
                                posts.description,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                )
              : Container();
        }),
      ),
    );
  }
}
