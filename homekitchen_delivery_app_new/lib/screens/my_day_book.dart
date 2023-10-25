import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';
import 'package:homekitchen_delivery_app_new/models/DriverRequestBook.dart';
import 'package:homekitchen_delivery_app_new/widgets/button_for_my_day.dart';
import 'package:intl/intl.dart';

import '../utils/map_utils.dart';

class MyDayBook extends StatefulWidget {
  DriverRequestBook? driverRequestBook;
  String? time;

  String? currentDate;
  MyDayBook({super.key, this.driverRequestBook, this.time});

  @override
  State<MyDayBook> createState() => _MyDayBookState();
}

class _MyDayBookState extends State<MyDayBook> {
  String? dateStage;
  String? currentDate;
  @override
  void initState() {
    super.initState();
    currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    Map<String, dynamic> match = findBestMatch(
        currentDate! + widget.time!, widget.driverRequestBook!.dateStage);
    dateStage = match['bestMatch']['target'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                renderConditionally(
                  whenCook: Text(
                    "The food is yet to be cooked",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  whenMoney: Text(
                    "Give Money to seller",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  whenSeller: Text(
                    "Take food from Seller",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  whenUser: Text(
                    "Deliver food to User",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  dateStage: dateStage,
                ),
                SizedBox(
                  height: 40,
                ),
                renderConditionally(
                    whenMoney: Image.asset(
                      "assets/images/MyDaySellerMoney.png",
                      height: 300,
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                    whenSeller: Image.asset(
                      "assets/images/foodFromSeller.png",
                      height: 300,
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                    whenUser: Image.asset(
                      "assets/images/MyDaySellerMoney.png",
                      height: 300,
                      width: 350,
                      fit: BoxFit.contain,
                    ),
                    whenCook: Image.asset(
                      "assets/images/cooking.jpg",
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    dateStage: dateStage),
                SizedBox(
                  height: 30,
                ),
                renderConditionally(
                  whenSeller: ButtonForMyDay(
                      onPressed: () async {
                        positions = await getCurrentLocation();
                        MapUtils.ShowMapsFromOneLocationToLocation(
                            positions[1],
                            positions[2],
                            widget.driverRequestBook!.sellerLat,
                            widget.driverRequestBook!.sellerLng);
                      },
                      text: "Navigate to Seller",
                      context: context),
                  whenCook: Container(),
                  whenUser: ButtonForMyDay(
                      onPressed: () async {
                        positions = await getCurrentLocation();
                        MapUtils.ShowMapsFromOneLocationToLocation(
                            positions[1],
                            positions[2],
                            widget.driverRequestBook!.userLat,
                            widget.driverRequestBook!.userlng);
                      },
                      text: "Navigate to User",
                      context: context),
                  whenMoney: ButtonForMyDay(
                      onPressed: () async {
                        positions = await getCurrentLocation();
                        MapUtils.ShowMapsFromOneLocationToLocation(
                            positions[1],
                            positions[2],
                            widget.driverRequestBook!.sellerLat,
                            widget.driverRequestBook!.sellerLng);
                      },
                      text: "Pay Online",
                      context: context),
                  dateStage: dateStage,
                ),
                SizedBox(
                  height: 20,
                ),
                renderConditionally(
                  dateStage: dateStage,
                  whenCook: Container(),
                  whenUser: ButtonForMyDay(
                      onPressed: () {
                        int index = widget.driverRequestBook!.dateStage
                            .indexWhere((item) => item == dateStage);
                        dateStage =
                            dateStage!.substring(0, dateStage!.length - 1) +
                                'M';
                        widget.driverRequestBook!.dateStage[index] = dateStage!;
                        FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("book")
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          "dateStage": widget.driverRequestBook!.dateStage
                        });
                        FirebaseFirestore.instance
                            .collection("driverRequest")
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          "dateStage": widget.driverRequestBook!.dateStage,
                        });
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => MyDayBook()));
                        // FirebaseFirestore.instance
                        //     .collection("Driver")
                        //     .doc(FirebaseAuth.instance.currentUser!.uid)
                        //     .collection("deliveries")
                        //     .doc(widget.driverRequest!.id)
                        //     .update({"stage": "toUser"}).then((value) {
                        //   DriverRequest? driverRequest2;
                        //   FirebaseFirestore.instance
                        //       .collection("Driver")
                        //       .doc(FirebaseAuth.instance.currentUser!.uid)
                        //       .collection("deliveries")
                        //       .doc(widget.driverRequest!.id)
                        //       .get()
                        //       .then((value) {
                        //     driverRequest2 = DriverRequest.fromJson(value.data()!);
                        //     Navigator.pop(context);
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (c) => MyDayDemoDetail(
                        //                   driverRequest: driverRequest2,
                        //                 )));
                        //   });
                        // });
                      },
                      text: "Already Given",
                      context: context),
                  whenMoney: ButtonForMyDay(
                      onPressed: () async {
                        int index = widget.driverRequestBook!.dateStage
                            .indexWhere((item) => item == dateStage);
                        widget.driverRequestBook!.dateStage.remove(dateStage);
                        FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("book")
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          "dateStage": widget.driverRequestBook!.dateStage
                        });
                        FirebaseFirestore.instance
                            .collection("driverRequest")
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          "dateStage": widget.driverRequestBook!.dateStage,
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.driverRequestBook!.sellerUID)
                            .collection('book')
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          'daysBetween': FieldValue.arrayRemove([
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          ])
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.driverRequestBook!.userUID)
                            .collection('book')
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          'daysBetween': FieldValue.arrayRemove([
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          ])
                        });
                        if (widget.driverRequestBook!.dateStage == []) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'userUnderMe': FieldValue.increment(-1),
                          });
                        }
                        Navigator.pop(context);
                        // FirebaseFirestore.instance
                        //     .collection("Driver")
                        //     .doc(FirebaseAuth.instance.currentUser!.uid)
                        //     .collection("deliveries")
                        //     .doc(widget.driverRequest!.id)
                        //     .update({"stage": "toUser"}).then((value) {
                        //   DriverRequest? driverRequest2;
                        //   FirebaseFirestore.instance
                        //       .collection("Driver")
                        //       .doc(FirebaseAuth.instance.currentUser!.uid)
                        //       .collection("deliveries")
                        //       .doc(widget.driverRequest!.id)
                        //       .get()
                        //       .then((value) {
                        //     driverRequest2 = DriverRequest.fromJson(value.data()!);
                        //     Navigator.pop(context);
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (c) => MyDayDemoDetail(
                        //                   driverRequest: driverRequest2,
                        //                 )));
                        //   });
                        // });
                      },
                      text: "Already Paid",
                      context: context),
                  whenSeller: ButtonForMyDay(
                      onPressed: () {
                        int index = widget.driverRequestBook!.dateStage
                            .indexWhere((item) => item == dateStage);
                        dateStage =
                            dateStage!.substring(0, dateStage!.length - 1) +
                                'U';
                        widget.driverRequestBook!.dateStage[index] = dateStage!;
                        FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("book")
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          "dateStage": widget.driverRequestBook!.dateStage
                        });
                        FirebaseFirestore.instance
                            .collection("driverRequest")
                            .doc(widget.driverRequestBook!.id)
                            .update({
                          "dateStage": widget.driverRequestBook!.dateStage,
                        });
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => MyDayBook()));
                        // FirebaseFirestore.instance
                        //     .collection("Driver")
                        //     .doc(FirebaseAuth.instance.currentUser!.uid)
                        //     .collection("deliveries")
                        //     .doc(widget.driverRequest!.id)
                        //     .update({"stage": "toUser"}).then((value) {
                        //   DriverRequest? driverRequest2;
                        //   FirebaseFirestore.instance
                        //       .collection("Driver")
                        //       .doc(FirebaseAuth.instance.currentUser!.uid)
                        //       .collection("deliveries")
                        //       .doc(widget.driverRequest!.id)
                        //       .get()
                        //       .then((value) {
                        //     driverRequest2 = DriverRequest.fromJson(value.data()!);
                        //     Navigator.pop(context);
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (c) => MyDayDemoDetail(
                        //                   driverRequest: driverRequest2,
                        //                 )));
                        //   });
                        // });
                      },
                      context: context,
                      text: "Already Taken"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget renderConditionally(
    {Widget? whenMoney,
    Widget? whenSeller,
    Widget? whenUser,
    Widget? whenCook,
    String? dateStage}) {
  String stage = dateStage![dateStage.length - 1];
  if (stage == "C") {
    return whenCook!;
  } else if (stage == "S") {
    return whenSeller!;
  } else if (stage == "U") {
    return whenUser!;
  } else {
    return whenMoney!;
  }
}
