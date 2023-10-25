import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/models/demo.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';

import '../global/utils/ad_mob_service.dart';
import '../global/utils/maputils.dart';
import '../globals.dart';
// ignore_for_file: must_be_immutable

class SellerYourDayDemo extends StatefulWidget {
  Demo demo;
  SellerYourDayDemo({super.key, required this.demo});

  @override
  State<SellerYourDayDemo> createState() => _SellerYourDayDemoState();
}

class _SellerYourDayDemoState extends State<SellerYourDayDemo> {
  List positions = [];
  Position? position;
  List<Placemark>? placemarks;
  getCurrentLocation() async {
    String completeAddress = '';
    Placemark? placemark;
    await Geolocator.requestPermission().whenComplete(() async {
      Position newPos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPos;
      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMark = placemarks![0];
      placemark = pMark;
      completeAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';
    });
    return [
      placemark,
      position!.latitude,
      position!.longitude,
      completeAddress,
    ];
  }

  double lan = 0;
  double lat = 0;
  TextEditingController reasonController = TextEditingController();
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  String? currentDate;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      positions = await getCurrentLocation();
      setState(() {
        lat = positions[1];
        lan = positions[2];
      });
      currentDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    });
    bannerAd = AdMobsService.createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bannerAd == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 52,
              child: AdWidget(
                ad: bannerAd!,
              ),
            ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                radius: 80,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.demo.userName,
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2A5A52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (c) => AlertDialog(
                                title: Text('Write a reason'),
                                content: TextField(
                                  autocorrect: true,
                                  controller: reasonController,
                                  maxLines: null,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        if (reasonController.text
                                            .trim()
                                            .isNotEmpty) {
                                          sendMessage(
                                              widget.demo.userToken,
                                              'Seller is not giving demo. We\'re sorry for Inconvenience 😞.',
                                              reasonController.text,
                                              context);
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection('demo')
                                              .doc(widget.demo.uid)
                                              .update({
                                            'done': true,
                                          });
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(widget.demo.userId)
                                              .collection('orders')
                                              .doc(widget.demo.uid)
                                              .update({
                                            'done': true,
                                          });
                                        } else {
                                          showSnackBar(context,
                                              'Please enter something in reason');
                                        }
                                      },
                                      child: Text('Submit')),
                                ],
                              ));
                    },
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'I don\'t want to give demo to this person',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2A5A52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    MapUtils.ShowMapsFromOneLocationToLocation(
                        lat, lan, widget.demo.userLat, widget.demo.userLng);
                  },
                  child: const Text(
                    'Navigate to User',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2A5A52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    FirebaseFirestore.instance
                        .collection("driverRequest")
                        .doc(widget.demo.uid)
                        .set({
                      "sellerName": sharedPreferences!.getString("name"),
                      "booked": false,
                      "city": sharedPreferences!.getString("city"),
                      "sellerLat": sharedPreferences!.getDouble("lat"),
                      "sellerLng": sharedPreferences!.getDouble("lng"),
                      "sellerUID": sharedPreferences!.getString("uid"),
                      "userUID": widget.demo.userId,
                      "sellerPhoneNumber":
                          sharedPreferences!.getString("phoneNumber"),
                      "sellerProfilePic": sharedPreferences!.getString("photo"),
                      "userName": widget.demo.userName,
                      "userAddress": widget.demo.completeAddress,
                      "orderType": "demo",
                      "latUser": widget.demo.userLat,
                      "lngUser": widget.demo.userLng,
                      "accepted": false,
                      "id": widget.demo.uid,
                      "stage": "toDriver",
                      "date": DateFormat("dd-MM-yyyy").format(DateTime.now()),
                      "done": false,
                      "deliveryPrice": widget.demo.deliveryPrice,
                      "totalPrice": widget.demo.totalPrice,
                    });

                    Workmanager().registerOneOffTask(
                      Uuid().v1(),
                      DateTime.now().millisecondsSinceEpoch.toString(),
                      initialDelay: Duration(seconds: 20),
                      inputData: <String, dynamic>{
                        'requestId': widget.demo.uid,
                        "context": context,
                      },
                    );
                  },
                  child: const Text(
                    'I have cooked my food',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
