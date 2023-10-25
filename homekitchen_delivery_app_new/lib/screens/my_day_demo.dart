import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';
import 'package:homekitchen_delivery_app_new/models/DriversRequest.dart';
import 'package:homekitchen_delivery_app_new/screens/my_day_payment.dart';
import 'package:homekitchen_delivery_app_new/utils/map_utils.dart';
import 'package:homekitchen_delivery_app_new/widgets/button_for_my_day.dart';

class MyDayDemoDetail extends StatefulWidget {
  DriverRequest? driverRequest;
  MyDayDemoDetail({super.key, this.driverRequest});

  @override
  State<MyDayDemoDetail> createState() => _MyDayDemoDetailState();
}

class _MyDayDemoDetailState extends State<MyDayDemoDetail> {
  Widget renderOn(
      {Widget? whenMoney,
      Widget? whenSeller,
      Widget? whenUser,
      String? stage}) {
    if (stage == "toSeller") {
      return whenSeller!;
    } else if (stage == "toUser") {
      return whenUser!;
    } else {
      return whenMoney!;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      positions = await getCurrentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20,
              ),
              renderOn(
                  whenMoney: Text(
                    "Give Money to Seller",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  whenSeller: Text(
                    "Take Food from Seller",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  whenUser: Text(
                    "Give food to User",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  stage: widget.driverRequest!.stage),
              SizedBox(
                height: 40,
              ),
              renderOn(
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
                  stage: widget.driverRequest!.stage),
              SizedBox(
                height: 30,
              ),
              renderOn(
                  whenMoney: ButtonForMyDay(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => MyDayPayment(
                                      driverRequest: widget.driverRequest,
                                      totalPrice: (int.parse(widget
                                                  .driverRequest!.totalPrice) -
                                              widget
                                                  .driverRequest!.deliveryPrice)
                                          .toInt(),
                                    )));
                      },
                      text: "Pay Online",
                      context: context),
                  whenSeller: ButtonForMyDay(
                      onPressed: () async {
                        positions = await getCurrentLocation();
                        MapUtils.ShowMapsFromOneLocationToLocation(
                            positions[1],
                            positions[2],
                            widget.driverRequest!.sellerLat,
                            widget.driverRequest!.sellerLng);
                      },
                      text: "Navigate to Seller",
                      context: context),
                  whenUser: ButtonForMyDay(
                      onPressed: () async {
                        positions = await getCurrentLocation();
                        MapUtils.ShowMapsFromOneLocationToLocation(
                            positions[1],
                            positions[2],
                            widget.driverRequest!.latUser,
                            widget.driverRequest!.lngUser);
                      },
                      text: "Navigate to User",
                      context: context),
                  stage: widget.driverRequest!.stage),
              SizedBox(
                height: 20,
              ),
              renderOn(
                  whenMoney: ButtonForMyDay(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("deliveries")
                            .doc(widget.driverRequest!.id)
                            .update({"stage": "done"}).then((value) {
                          DriverRequest? driverRequest2;
                          FirebaseFirestore.instance
                              .collection("Driver")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("deliveries")
                              .doc(widget.driverRequest!.id)
                              .get()
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.driverRequest!.userUID)
                                .collection('orders')
                                .doc(widget.driverRequest!.id)
                                .update({"done": true});
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.driverRequest!.sellerUID)
                                .collection('demo')
                                .doc(widget.driverRequest!.id)
                                .update({"stage": "done", "done": true});
                            FirebaseFirestore.instance
                                .collection("Driver")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("deliveries")
                                .doc(widget.driverRequest!.id)
                                .update({
                              "done": true,
                            });
                            driverRequest2 =
                                DriverRequest.fromJson(value.data()!);
                            Navigator.pop(context);
                          });
                        });
                      },
                      text: "Already Paid",
                      context: context),
                  // "I have given ${int.parse(widget.driverRequest!.totalPrice) - widget.driverRequest!.deliveryPrice} to seller",
                  whenSeller: ButtonForMyDay(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("deliveries")
                            .doc(widget.driverRequest!.id)
                            .update({"stage": "toUser"}).then((value) {
                          DriverRequest? driverRequest2;
                          FirebaseFirestore.instance
                              .collection("Driver")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("deliveries")
                              .doc(widget.driverRequest!.id)
                              .get()
                              .then((value) {
                            driverRequest2 =
                                DriverRequest.fromJson(value.data()!);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => MyDayDemoDetail(
                                          driverRequest: driverRequest2,
                                        )));
                          });
                        });
                      },
                      text: "Already Taken",
                      context: context),
                  whenUser: ButtonForMyDay(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("deliveries")
                            .doc(widget.driverRequest!.id)
                            .update({"stage": "givingMoney"}).then((value) {
                          DriverRequest? driverRequest2;
                          FirebaseFirestore.instance
                              .collection("Driver")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("deliveries")
                              .doc(widget.driverRequest!.id)
                              .get()
                              .then((value) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.driverRequest!.userUID)
                                .collection('orders')
                                .doc(widget.driverRequest!.id)
                                .update({"done": true});
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.driverRequest!.sellerUID)
                                .collection('demo')
                                .doc(widget.driverRequest!.id)
                                .update({"stage": "givingMoney"});
                            driverRequest2 =
                                DriverRequest.fromJson(value.data()!);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => MyDayDemoDetail(
                                          driverRequest: driverRequest2,
                                        )));
                          });
                        });
                      },
                      text: "Already Given",
                      context: context),
                  stage: widget.driverRequest!.stage)
            ],
          ),
        ),
      )),
    );
  }
}
