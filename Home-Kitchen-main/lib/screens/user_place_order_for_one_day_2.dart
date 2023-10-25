import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_kitchen/global/utils/cloud_messaging.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/item.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/screens/user_home_screen.dart';
import 'package:home_kitchen/screens/user_place_order_for_one_day_3.dart';
import 'package:uuid/uuid.dart';

import '../global/widgets/status.dart';

class UserPlaceOrderForOneDayStep2 extends StatefulWidget {
  String date;
  String time;
  Seller seller;
  Item item;
  List selectedAddons;
  double deliveryPrice;
  UserPlaceOrderForOneDayStep2({
    super.key,
    required this.item,
    required this.selectedAddons,
    required this.date,
    required this.time,
    required this.seller,
    required this.deliveryPrice,
  });

  @override
  State<UserPlaceOrderForOneDayStep2> createState() =>
      _UserPlaceOrderForOneDayStep2State();
}

class _UserPlaceOrderForOneDayStep2State
    extends State<UserPlaceOrderForOneDayStep2> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Status(
                index: 0,
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
                            'Order Info',
                            style: TextStyle(fontSize: 30),
                          )),
                      ListTile(
                        title: Text(
                          widget.date,
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Date',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          widget.time,
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'Time',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      widget.selectedAddons == null
                          ? Container()
                          : Text(
                              'Addons',
                              style: TextStyle(fontSize: 30),
                            ),
                      widget.selectedAddons == null
                          ? Container()
                          : ListView.builder(
                              itemCount: widget.selectedAddons.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48.0),
                                  child: ListTile(
                                    trailing: Text(
                                      "₹${widget.selectedAddons[index]['price']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xffd9d9d9)),
                                    ),
                                    leading: Text(
                                      widget.selectedAddons[index]['item'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 167, 167, 167)),
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                            ),
                    ],
                  ),
                ),
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
                            'Seller Info',
                            style: TextStyle(fontSize: 30),
                          )),
                      ListTile(
                        title: Text(
                          widget.seller.name,
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
                        title: Text(
                          widget.seller.address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color: Color(0xffD9D9D9)),
                        ),
                        leading: const Text(
                          'address',
                          style: TextStyle(
                            fontSize: 20,
                          ),
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
                          widget.seller.phoneNumber,
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
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2A5A52),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => UserPlaceOrderForOneDay3(
                                  item: widget.item,
                                  selectedAddons: widget.selectedAddons,
                                  date: widget.date,
                                  time: widget.time,
                                  seller: widget.seller,
                                  deliveryPrice: widget.deliveryPrice)));
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
