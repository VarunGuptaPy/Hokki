import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/models/DriverRequestBook.dart';
import 'package:homekitchen_delivery_app_new/models/DriversRequest.dart';
import 'package:homekitchen_delivery_app_new/screens/ask_for_what_day.dart';
import 'package:homekitchen_delivery_app_new/screens/my_day_book.dart';
import 'package:homekitchen_delivery_app_new/screens/my_day_demo.dart';
import 'package:intl/intl.dart';

class MyDay extends StatefulWidget {
  const MyDay({super.key});

  @override
  State<MyDay> createState() => _MyDayState();
}

class _MyDayState extends State<MyDay> {
  String? currentDate;
  String? differentDate;
  int? tabIndex = 0;
  @override
  void initState() {
    super.initState();
    currentDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    differentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    print(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorColor: Color(0xff2F4858),
                labelColor: Colors.black,
                onTap: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
                tabs: [
                  Tab(
                    child: GestureDetector(
                      child: Text(
                        "Demo",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tabIndex == 0
                                ? Color(0xff2F4858)
                                : Colors.black),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Tab(
                      child: Text(
                        "Bookers",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tabIndex == 1
                                ? Color(0xff2F4858)
                                : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("deliveries")
                            .where("date", isEqualTo: currentDate)
                            .where("done", isEqualTo: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    DriverRequest driverRequest =
                                        DriverRequest.fromJson(
                                            snapshot.data!.docs[index].data()
                                                as Map<String, dynamic>);
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 20),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  driverRequest
                                                      .sellerProfilePic)),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (c) => MyDayDemoDetail(
                                                  driverRequest: driverRequest,
                                                ),
                                              ),
                                            );
                                          },
                                          title:
                                              driverRequest.stage == "toSeller"
                                                  ? Text(
                                                      "You have to go to ${driverRequest.sellerName} to pickup order",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    )
                                                  : driverRequest.stage ==
                                                          "givingMoney"
                                                      ? Text(
                                                          "You have to go to ${driverRequest.sellerName} to deliver give money.",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            // fontWeight:
                                                            // FontWeight.bold,
                                                          ),
                                                        )
                                                      : Text(
                                                          "You have to go to ${driverRequest.userName} to deliver food.",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            // fontWeight:
                                                            // FontWeight.bold,
                                                          ),
                                                        ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length,
                                )
                              : Container();
                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Driver")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("book")
                            .where('daysBetween', arrayContains: differentDate)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DriverRequestBook driverRequestBook =
                                        DriverRequestBook.fromMap(
                                            snapshot.data!.docs[index].data()
                                                as Map<String, dynamic>);
                                    bool day = false;
                                    bool night = false;
                                    if (driverRequestBook.daysWanted.contains(
                                        DateFormat('EEEE')
                                                .format(DateTime.now())
                                                .toLowerCase() +
                                            'Days')) {
                                      day = true;
                                    }
                                    if (driverRequestBook.daysWanted.contains(
                                        DateFormat('EEEE')
                                                .format(DateTime.now())
                                                .toLowerCase() +
                                            'Nights')) {
                                      night = true;
                                    }
                                    if (day || night) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: Material(
                                          elevation: 5,
                                          child: ListTile(
                                            onTap: () {
                                              if (day && night) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (c) =>
                                                        AskForWhatDay(
                                                      driverRequest:
                                                          driverRequestBook,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                if (day && !night) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (c) =>
                                                              MyDayBook(
                                                                driverRequestBook:
                                                                    driverRequestBook,
                                                                time: "D",
                                                              )));
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (c) =>
                                                              MyDayBook(
                                                                driverRequestBook:
                                                                    driverRequestBook,
                                                                time: "N",
                                                              )));
                                                }
                                              }
                                            },
                                            leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    driverRequestBook
                                                        .sellerProfilePic)),
                                            title: renderTitleBook(
                                                day, night, driverRequestBook),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                )
                              : Container();
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  renderTitleBook(bool day, bool night, DriverRequestBook book) {
    if (day && !night)
      return Text(
        'you have to deliver food to ${book.userName} today at day',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          // fontWeight:
          // FontWeight.bold,
        ),
      );
    if (day && night)
      return Text(
        'you have to deliver food to ${book.userName} today at day and night',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          // fontWeight:
          // FontWeight.bold,
        ),
      );
    if (!day && night)
      return Text(
        'you have to deliver food to ${book.userName} today at night',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          // fontWeight:
          // FontWeight.bold,
        ),
      );
  }
}
