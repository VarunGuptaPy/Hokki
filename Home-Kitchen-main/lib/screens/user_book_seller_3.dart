import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/screens/user_home_screen.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/item.dart';

class UserBookSeller2 extends StatefulWidget {
  final difference;
  final DaysWanted;
  final DaysNotWanted;
  final dayStart;
  final dayEnd;
  final timeStarted;
  final timeEnded;
  final paymentWay;
  double deliveryPrice;
  Item item;
  List addonsSelected;
  Seller seller;
  UserBookSeller2(
      {super.key,
      required this.deliveryPrice,
      required this.item,
      required this.addonsSelected,
      required this.difference,
      required this.DaysWanted,
      required this.DaysNotWanted,
      required this.dayStart,
      required this.dayEnd,
      required this.timeStarted,
      required this.timeEnded,
      this.paymentWay,
      required this.seller});
  @override
  State<UserBookSeller2> createState() => _UserBookSeller2State();
}

class _UserBookSeller2State extends State<UserBookSeller2> {
  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  int addonsPrice = 0;
  @override
  void initState() {
    super.initState();
    if (widget.addonsSelected.isNotEmpty) {
      for (var element in widget.addonsSelected) {
        addonsPrice += int.parse(element['price']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'Order Detail',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Days wanted',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.DaysWanted.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Color(0xff009E86),
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: ListTile(
                            leading: Icon(
                              Icons.donut_large,
                              color: Colors.white,
                            ),
                            title: Text(
                              widget.DaysWanted[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    'Days Not Wanted',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.DaysNotWanted.length == 0
                      ? Text(
                          'none',
                          style: TextStyle(fontSize: 20),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.DaysNotWanted.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Material(
                                color: Color(0xff009E86),
                                elevation: 5,
                                borderRadius: BorderRadius.circular(20),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.donut_large,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    widget.DaysNotWanted[index],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.addonsSelected.length == 0
                      ? Container()
                      : Text(
                          'Addons',
                          style: TextStyle(fontSize: 30),
                        ),
                  widget.addonsSelected.length == 0
                      ? Container()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.addonsSelected.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title:
                                    Text(widget.addonsSelected[index]['item']),
                                trailing:
                                    Text(widget.addonsSelected[index]['price']),
                              ),
                            );
                          },
                        ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Seller Detail',
                        style: TextStyle(fontSize: 20),
                      ),
                      ListTile(
                        leading: Text('Name: '),
                        title: Text(widget.seller.name),
                      ),
                      ListTile(
                        leading: Text('Address: '),
                        title: Text(widget.seller.address),
                      ),
                      ListTile(
                        leading: Text('Phone Number: '),
                        title: Text(widget.seller.phoneNumber),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your address Detail',
                        style: TextStyle(fontSize: 25),
                      ),
                      ListTile(
                        leading: Text(
                          'Complete Addres: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text(
                          completeAddress!,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Your Name: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text(sharedPreferences!.getString('name')!),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Price by the end',
                        style: TextStyle(fontSize: 20),
                      ),
                      ListTile(
                        leading: Text(
                          'Food Price: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text(
                            (int.parse(widget.item.price) * widget.difference)
                                .toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      addonsPrice == 0
                          ? Container()
                          : ListTile(
                              leading: Text(
                                'Addons Price: ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              title: Text(
                                  (addonsPrice * widget.difference).toString()),
                            ),
                      addonsPrice == 0
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 2,
                                color: Colors.black,
                              ),
                            ),
                      ListTile(
                        leading: Text(
                          "One Time Delivery price",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text(widget.deliveryPrice.toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Total Delivery price by the end",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text((widget.deliveryPrice * widget.difference)
                            .toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          "Total One Time price",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text((widget.deliveryPrice +
                                int.parse(widget.item.price) +
                                addonsPrice)
                            .toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      ListTile(
                        leading: Text(
                          'Total Price by the end: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        title: Text((addonsPrice * widget.difference +
                                int.parse(widget.item.price) *
                                    widget.difference +
                                widget.deliveryPrice * widget.difference)
                            .toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                        String id = Uuid().v1();
                        List date = [];
                        for (var element in getDaysInBetween(
                            widget.timeStarted, widget.timeEnded)) {
                          String days =
                              DateFormat('EEEEE').format(element).toLowerCase();
                          if (widget.DaysWanted.contains(days + 'Days')) {
                            date.add(DateFormat('yyyy-MM-dd').format(element));
                          }
                          if (widget.DaysWanted.contains(days + 'Nights')) {
                            date.add(DateFormat('yyyy-MM-dd').format(element));
                          }
                        }
                        List<String> datesWithStage = [];
                        for (String dateStage in date) {
                          List<String> dateComponents = dateStage.split('-');

                          // Parse the day, month, and year from the components.
                          int day = int.parse(dateComponents[0]);
                          int month = int.parse(dateComponents[1]);
                          int year = int.parse(dateComponents[2]);

                          // Create a DateTime object from the components.
                          DateTime givenDate = DateTime(year, month, day);
                          bool hasDay = false;
                          bool hasNight = false;
                          if (widget.DaysWanted.contains(DateFormat('EEEE')
                                  .format(givenDate)
                                  .toLowerCase() +
                              'Days')) {
                            hasDay = true;
                          }
                          if (widget.DaysWanted.contains(DateFormat('EEEE')
                                  .format(givenDate)
                                  .toLowerCase() +
                              'Nights')) {
                            hasNight = true;
                          }
                          if (hasDay) {
                            datesWithStage!.add(dateStage +
                                "DC"); // D - Day, N - Night, C - Cooking,  S - Seller, U - User, M - Giving money
                          }
                          if (hasNight) {
                            datesWithStage!.add(dateStage + "NC");
                          }
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.seller.uid)
                              .collection('book')
                              .doc(id)
                              .set({
                            "driverUID": "",
                            'id': id,
                            'userUID': FirebaseAuth.instance.currentUser!.uid,
                            'daysBetween': date,
                            'daysWanted': widget.DaysWanted,
                            'daysNotWanted': widget.DaysNotWanted,
                            'startDate': widget.dayStart,
                            'endDate': widget.dayEnd,
                            'userAddress': completeAddress,
                            'userLat': latUser,
                            'userlng': lngUser,
                            'userName': sharedPreferences!.getString('name'),
                            'userToken': sharedPreferences!.getString('Token'),
                            'userPhoneNumber':
                                sharedPreferences!.getString('phoneNumber'),
                            'price': int.parse(widget.item.price) *
                                    widget.difference +
                                addonsPrice * widget.difference +
                                widget.deliveryPrice * widget.difference,
                            'addonsPrice': addonsPrice,
                            'foodPrice': int.parse(widget.item.price) *
                                widget.difference,
                            "deliveryPrice": widget.deliveryPrice,
                          });
                        }
                        FirebaseFirestore.instance
                            .collection('driverRequest')
                            .doc(id)
                            .set({
                          'id': id,
                          'userUID': FirebaseAuth.instance.currentUser!.uid,
                          'daysBetween': date,
                          "dateStage": datesWithStage,
                          'daysWanted': widget.DaysWanted,
                          'daysNotWanted': widget.DaysNotWanted,
                          'startDate': widget.dayStart,
                          'endDate': widget.dayEnd,
                          'userAddress': completeAddress,
                          'userLat': latUser,
                          'userlng': lngUser,
                          'userName': sharedPreferences!.getString('name'),
                          // 'userToken': sharedPreferences!.getString('Token'),
                          'userPhoneNumber':
                              sharedPreferences!.getString('phoneNumber'),
                          'oneTimePrice': widget.item.price,
                          'price':
                              int.parse(widget.item.price) * widget.difference +
                                  addonsPrice * widget.difference,
                          'addonsPrice': addonsPrice,
                          'foodPrice':
                              int.parse(widget.item.price) * widget.difference,
                          "itemOneTimePrice": int.parse(widget.item.price),
                          "sellerUID": widget.seller.uid,
                          "sellerName": widget.seller.name,
                          "sellerLat": widget.seller.lat,
                          "sellerLng": widget.seller.lng,
                          "sellerAddress": widget.seller.address,
                          "orderType": "book",
                          "accepted": false,
                          "done": false,
                          "sellerProfilePic": widget.seller.profilePic,
                          "city": widget.seller.city,
                          "date":
                              DateFormat("dd-MM-yyyy").format(DateTime.now()),
                          "driverUID": "",
                          "deliveryPrice": widget.deliveryPrice,
                          "foodAndAddonPrice":
                              int.parse(widget.item.price) + addonsPrice,
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.seller.uid)
                            .update({
                          'userUnderMe': FieldValue.increment(1),
                        });
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('book')
                            .doc(id)
                            .set({
                          'driverUID': "",
                          'id': id,
                          'sellerUID': widget.seller.uid,
                          'daysBetween': date,
                          'daysWanted': widget.DaysWanted,
                          'daysNotWanted': widget.DaysNotWanted,
                          'startDate': widget.dayStart,
                          'endDate': widget.dayEnd,
                          'sellerAddress': widget.seller.address,
                          'sellerLat': widget.seller.lat,
                          'sellerlng': widget.seller.lng,
                          'sellerPhoto': widget.seller.profilePic,
                          'sellerName': widget.seller.name,
                          'sellerPhoneNumber': widget.seller.phoneNumber,
                          'price':
                              int.parse(widget.item.price) * widget.difference +
                                  addonsPrice * widget.difference +
                                  widget.deliveryPrice * widget.difference,
                          'addonsPrice': addonsPrice,
                          'foodPrice':
                              int.parse(widget.item.price) * widget.difference,
                          'deliveryPrice':
                              int.parse(widget.item.price) * widget.difference
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) => UserHomeScreen()));
                      },
                      child: Text('Proceed',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
