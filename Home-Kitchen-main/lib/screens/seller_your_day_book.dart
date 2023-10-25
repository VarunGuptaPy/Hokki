import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';
import 'package:home_kitchen/global/utils/otp_related.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/models/DriverRequestBook.dart';
import 'package:home_kitchen/models/bookSeller.dart';
import 'package:home_kitchen/screens/seller_your_day_otp_screen.dart';
import 'package:intl/intl.dart';
import '../global/utils/ad_mob_service.dart';
import '../global/utils/maputils.dart';
import '../globals.dart';
// ignore_for_file: must_be_immutable

class SellerYourDayBook extends StatefulWidget {
  BookSeller bookSeller;
  String? time;
  SellerYourDayBook({super.key, required this.bookSeller, this.time});

  @override
  State<SellerYourDayBook> createState() => _SellerYourDayBookState();
}

class _SellerYourDayBookState extends State<SellerYourDayBook> {
  List positions = [];
  Position? position;
  String? currentDate;
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
  List<dynamic> dateStages = [];
  InterstitialAd? interstitialAd;
  String? dateStage;
  int? dateStageIndex;
  List<String> dateStageList = [];
  DriverRequestBook? driverRequestBook;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      positions = await getCurrentLocation();
      setState(() {
        lat = positions[1];
        lan = positions[2];
      });
    });
    bannerAd = AdMobsService.createBannerAd();
    FirebaseFirestore.instance
        .collection("driverRequest")
        .doc(widget.bookSeller.id)
        .get()
        .then((value) {
      var data = value.data()!;
      driverRequestBook = DriverRequestBook.fromMap(data);
      dateStages = driverRequestBook!.dateStage;
      currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      Map<String, dynamic> match =
          findBestMatch(currentDate! + widget.time!, dateStages);
      dateStage = match['bestMatch']['target'];
      dateStageIndex = dateStages.indexOf(dateStage);
      dateStageList = dateStage!.split('');
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
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
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                radius: 64,
              ),
              Text(
                widget.bookSeller.userName,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          SizedBox(
            height: 30,
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
                  MapUtils.ShowMapsFromOneLocationToLocation(lat, lan,
                      widget.bookSeller.userLat, widget.bookSeller.userlng);
                },
                child: Text(
                  'Navigate to User',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
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
                            title: Text('Enter reason for doing so'),
                            content: TextField(
                              autocorrect: true,
                              maxLines: null,
                              controller: reasonController,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (reasonController.text.trim() != '') {
                                      sendMessage(
                                          widget.bookSeller.userToken,
                                          'Sorry !😞 Seller is not giving food today. \n But more tasty food is waiting for you 😋😋.',
                                          reasonController.text,
                                          context);
                                      Navigator.pop(context);
                                    } else {
                                      showSnackBar(
                                          context, 'Please give reason');
                                    }
                                  },
                                  child: Text('Submit')),
                            ],
                          ));
                },
                child: Text(
                  'I will not give food',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       int otp = GetOtp();
          //       print(otp);
          //       sendMessage(widget.bookSeller.userToken, 'OTP for seller',
          //           otp.toString(), context);
          //       var map = Map();

          //       widget.bookSeller.daysBetween.forEach((element) {
          //         if (!map.containsKey(element)) {
          //           map[element] = 1;
          //         } else {
          //           map[element] += 1;
          //         }
          //       });
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (c) => SellerYourDayOtpScreen(
          //                   times: map[DateFormat('yyyy-MM-dd')
          //                       .format(DateTime.now())],
          //                   Otp: otp,
          //                   type: 'book',
          //                   orderId: widget.bookSeller.id,
          //                   userId: widget.bookSeller.userUID)));
          //     },
          //     child: Text('I have delivered food for today')),
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
                  if (dateStageList[dateStageList.length - 1] == "C") {
                    dateStageList[dateStageList.length - 1] = "S";
                    dateStages[dateStageIndex!] = dateStageList.join("");
                    FirebaseFirestore.instance
                        .collection("driverRequest")
                        .doc(widget.bookSeller.id)
                        .update({
                      "dateStage": dateStages,
                    });
                    FirebaseFirestore.instance
                        .collection("Driver")
                        .doc(driverRequestBook!.driverUID)
                        .collection("book")
                        .doc(driverRequestBook!.id)
                        .update({
                      "dateStage": dateStages,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'I have cooked food.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
