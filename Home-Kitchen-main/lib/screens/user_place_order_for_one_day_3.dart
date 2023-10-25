import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';
import 'package:home_kitchen/global/widgets/status.dart';
import 'package:home_kitchen/screens/success_screen.dart';
import 'package:home_kitchen/screens/user_home_screen.dart';
import 'package:uuid/uuid.dart';

import '../globals.dart';
import '../models/item.dart';
import '../models/seller.dart';

class UserPlaceOrderForOneDay3 extends StatefulWidget {
  String date;
  String time;
  Seller seller;
  Item item;
  List selectedAddons;
  double deliveryPrice;
  UserPlaceOrderForOneDay3({
    super.key,
    required this.item,
    required this.selectedAddons,
    required this.date,
    required this.time,
    required this.seller,
    required this.deliveryPrice,
  });

  @override
  State<UserPlaceOrderForOneDay3> createState() =>
      _UserPlaceOrderForOneDay3State();
}

class _UserPlaceOrderForOneDay3State extends State<UserPlaceOrderForOneDay3> {
  int AddonsPrice = 0;
  double? distanceBetween;
  @override
  void initState() {
    super.initState();
    for (var element in widget.selectedAddons) {
      AddonsPrice += int.parse(element['price']);
    }
    distanceBetween = Geolocator.distanceBetween(
        latUser, lngUser, widget.seller.lat, widget.seller.lng);
  }

  TextEditingController addressController =
      TextEditingController(text: completeAddress!);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Status(
                index: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Your Info',
                            style: TextStyle(fontSize: 30),
                          )),
                      ListTile(
                        title: Text(
                          sharedPreferences!.getString('name')!,
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Name',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        title: TextField(
                            controller: addressController,
                            style: TextStyle(color: Color(0xffD9D9D9)),
                            decoration:
                                InputDecoration(border: InputBorder.none)),
                        leading: const Text(
                          'address',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          sharedPreferences!.getString('phoneNumber')!,
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(40),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Total Cost',
                            style: TextStyle(fontSize: 30),
                          )),
                      ListTile(
                        title: Text(
                          widget.item.price,
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Total food cost:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          widget.deliveryPrice.toString(),
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Total delivery price:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      widget.selectedAddons.length == 0
                          ? Container()
                          : ListTile(
                              title: Text(
                                AddonsPrice.toString(),
                                style: TextStyle(color: Color(0xffD9D9D9)),
                              ),
                              leading: const Text(
                                'Addons price',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          (int.parse(widget.item.price) +
                                  AddonsPrice +
                                  widget.deliveryPrice)
                              .toString(),
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Total price:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2A5A52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {
                  requstPermission();
                  sendMessage(
                      widget.seller.Token,
                      '${sharedPreferences!.getString('name')!} wants a demo',
                      'A user named ${sharedPreferences!.getString('name')!} wants a demo of your food at ${widget.date} at ${widget.time}',
                      context);
                  String uid = const Uuid().v1();
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.seller.uid)
                      .collection('demo')
                      .doc(uid)
                      .set({
                    'userName': sharedPreferences!.getString('name'),
                    'completeAddress': completeAddress,
                    'phoneNumber': sharedPreferences!.getString('phoneNumber'),
                    'userLat': latUser,
                    'userLng': lngUser,
                    'done': false,
                    'uid': uid,
                    'date': widget.date,
                    'time': widget.time,
                    'userId': FirebaseAuth.instance.currentUser!.uid,
                    'userToken': sharedPreferences!.getString('Token'),
                    'orderId': uid,
                    'addons': widget.selectedAddons,
                    'foodprice': widget.item.price,
                    'addonsPrice': AddonsPrice.toString(),
                    'totalPrice':
                        (int.parse(widget.item.price) + AddonsPrice).toString(),
                    "stage": "cooking",
                    "deliveryPrice": widget.deliveryPrice,
                  });

                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('orders')
                      .doc(uid)
                      .set({
                    'sellerName': widget.seller.name,
                    'sellerAddress': widget.seller.address,
                    'sellerLat': widget.seller.lat,
                    'sellerLng': widget.seller.lng,
                    'done': false,
                    'sellerPhoto': widget.seller.profilePic,
                    'date': widget.date,
                    'time': widget.time,
                    'sellerId': widget.seller.uid,
                    'orderId': uid,
                    'addons': widget.selectedAddons,
                    'foodprice': widget.item.price,
                    'addonsPrice': AddonsPrice.toString(),
                    'totalPrice':
                        (int.parse(widget.item.price) + AddonsPrice).toString(),
                    "stage": "cooking",
                    "deliveryPrice": widget.deliveryPrice,
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => SuccessScreen(
                                title: "Order Placed",
                                subtitle:
                                    "Your order has been placed successfully.",
                                buttonText: "Complete",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => UserHomeScreen()));
                                },
                              )));
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
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
