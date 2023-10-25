import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/models/DriversRequest.dart';
import 'package:intl/intl.dart';

class MoneyDueScreen extends StatefulWidget {
  const MoneyDueScreen({super.key});

  @override
  State<MoneyDueScreen> createState() => _MoneyDueScreenState();
}

class _MoneyDueScreenState extends State<MoneyDueScreen> {
  int tabIndex = 0;
  String? currentDate;
  String? differentDate;
  @override
  void initState() {
    // TODO: implement initState
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Driver")
                        .doc()
                        .collection("deliveries")
                        .where("date", isNotEqualTo: currentDate)
                        .where("done", isEqualTo: false)
                        .where("stage", isEqualTo: "givingMoney")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                DriverRequest driverRequest =
                                    DriverRequest.fromJson(
                                        snapshot.data!.docs[index].data());
                                return Column(
                                  children: [
                                    Text(
                                        "You have to pay to ${driverRequest.sellerName} ")
                                  ],
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            )
                          : Container();
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Driver")
                        .doc()
                        .collection("deliveries")
                        .where("date", isNotEqualTo: currentDate)
                        .where("done", isEqualTo: false)
                        .where("stage", isEqualTo: "givingMoney")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                DriverRequest driverRequest =
                                    DriverRequest.fromJson(
                                        snapshot.data!.docs[index].data());
                              },
                              itemCount: snapshot.data!.docs.length,
                            )
                          : Container();
                    },
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
