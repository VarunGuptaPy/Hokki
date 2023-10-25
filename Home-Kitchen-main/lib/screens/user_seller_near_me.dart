import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/global/widgets/slider_dialog.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/posts.dart';
import 'package:home_kitchen/models/seller.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:home_kitchen/screens/user_seller_profile_screen.dart';

import '../global/utils/ad_mob_service.dart';

class UserSellerNearMe extends StatefulWidget {
  const UserSellerNearMe({super.key});

  @override
  State<UserSellerNearMe> createState() => _UserSellerNearMeState();
}

BannerAd? bannerAd;
InterstitialAd? interstitialAd;
int? deliveryPrice;
double? distanceBetweenUserSeller = 2;

class _UserSellerNearMeState extends State<UserSellerNearMe> {
  bool? showUI = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerAd = AdMobsService.createBannerAd();
    FirebaseFirestore.instance
        .collection("importantData")
        .doc("importantData")
        .get()
        .then(
      (value) {
        showDialog(
          context: context,
          builder: (c) => SliderDialog(
            min: 1,
            max: 5,
            diversion: 8,
            title: "Distace between you and seller",
            writeBeforeValue: "Distance (in Kilometer)",
            onDone: (currentValue) {
              setState(() {
                showUI = true;
              });
              deliveryPrice = value.data()!["costPerKm"];
              distanceBetweenUserSeller = currentValue;
              Navigator.pop(context);
            },
            onCancel: () {
              setState(() {
                showUI = true;
              });
              distanceBetweenUserSeller = 2;
              Navigator.pop(context);
            },
            showDeliverPrice: true,
            deliveryPrice: value.data()!["costPerKm"],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderUI(showUI!),
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

Widget renderUI(bool showUI) {
  if (showUI) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where(
            'role',
            isEqualTo: 'seller',
          )
          .where('city', isEqualTo: city)
          .where('active', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index].data();
                  Seller seller = Seller.fromMap(snapshot.data!.docs[index]
                      .data()! as Map<String, dynamic>);
                  double distanceBetween = Geolocator.distanceBetween(
                          latUser, lngUser, seller.lat, seller.lng) /
                      1000;
                  if (distanceBetween <= distanceBetweenUserSeller!) {
                    int? totalDeliveryCost;
                    if (distanceBetweenUserSeller! < 1) {
                      totalDeliveryCost = deliveryPrice!.toInt();
                    } else {
                      totalDeliveryCost =
                          (deliveryPrice! * distanceBetweenUserSeller!).toInt();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: Border.all(color: Colors.black)),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => UserSellerProfileScreen(
                                            seller: seller,
                                            deliveryPrice:
                                                deliveryPrice!.toDouble(),
                                          )));
                            },
                            child: Column(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('highlights')
                                      .where('uid', isEqualTo: seller.uid)
                                      .snapshots(),
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    return snapshot.hasData
                                        ? snapshot.data!.docs.length == 0
                                            ? Container()
                                            : CarouselSlider.builder(
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder: (context, index,
                                                    realIndex) {
                                                  Posts? posts = Posts.fromMap(
                                                      snapshot.data!.docs[index]
                                                              .data()!
                                                          as Map<String,
                                                              dynamic>);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      child: Image.network(
                                                          posts.downloadUrl,
                                                          height: 600,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  );
                                                },
                                                options: CarouselOptions(
                                                    autoPlay: true,
                                                    enableInfiniteScroll: true))
                                        : Container();
                                  }),
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(seller.profilePic),
                                  ),
                                  title: Text(seller.name),
                                  subtitle: Text(seller.role),
                                  trailing: Text(
                                      '${distanceBetween.toStringAsFixed(2)} km'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data!.docs.length,
              )
            : Container();
      },
    );
  } else {
    return Container();
  }
}
