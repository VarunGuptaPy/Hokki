import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';
import 'package:intl/intl.dart';

import '../global/utils/ad_mob_service.dart';
// ignore_for_file: must_be_immutable

class SellerYourDayOtpScreen extends StatefulWidget {
  int Otp;
  String type;
  String orderId;
  String userId;
  int? times = 2;
  SellerYourDayOtpScreen(
      {super.key,
      this.times,
      required this.Otp,
      required this.type,
      required this.orderId,
      required this.userId});

  @override
  State<SellerYourDayOtpScreen> createState() => _SellerYourDayOtpScreenState();
}

class _SellerYourDayOtpScreenState extends State<SellerYourDayOtpScreen> {
  TextEditingController otpController = TextEditingController();
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
      bottomNavigationBar: bannerAd == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 52,
              child: AdWidget(
                ad: bannerAd!,
              ),
            ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: '- - - -'),
                  controller: otpController,
                )),
            ElevatedButton(
                onPressed: () async {
                  if (widget.Otp == int.parse(otpController.text)) {
                    if (widget.type == 'demo') {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('demo')
                          .doc(widget.orderId)
                          .update({
                        'done': true,
                      });
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .collection('orders')
                          .doc(widget.orderId)
                          .update({
                        'done': true,
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (c) => SellerHomeScreen(),
                        ),
                      );
                    } else {
                      List listOfDays = [];
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('book')
                          .doc(widget.orderId)
                          .update({
                        'price': FieldValue.increment(int.parse(price) * 2),
                        'daysBetween': widget.times == 2
                            ? FieldValue.arrayRemove([
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                DateFormat('yyyy-MM-dd').format(DateTime.now())
                              ])
                            : FieldValue.arrayRemove([
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              ])
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.userId)
                          .collection('book')
                          .doc(widget.orderId)
                          .update({
                        'price': FieldValue.increment(int.parse(price) * 2),
                        'daysBetween': widget.times == 2
                            ? FieldValue.arrayRemove([
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                DateFormat('yyyy-MM-dd').format(DateTime.now())
                              ])
                            : FieldValue.arrayRemove([
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              ])
                      });
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('book')
                          .doc(widget.orderId)
                          .get()
                          .then((value) {
                        listOfDays = value.data()!['daysBetween'];
                      });
                      if (listOfDays.isEmpty) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'userUnderMe': FieldValue.increment(-1),
                        });
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (c) => SellerHomeScreen()));
                    }
                  } else {
                    showSnackBar(context, 'Wrong OTP');
                  }
                },
                child: Text('Verify'))
          ],
        ),
      ),
    );
  }
}
