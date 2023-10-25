import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';
import 'package:homekitchen_delivery_app_new/screens/money_due_screen.dart';

import '../auth/ask_for_login_and_signUp.dart';

class DetailsScreen extends StatefulWidget {
  int? selectedIndex;
  DetailsScreen({super.key, this.selectedIndex});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: const Text(
            "HOME",
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text("Welcome back, ${driverData!.name}!"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const AskForLoginAndSginUp()));
                },
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      elevation: 7,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        child: Column(
                          children: [
                            Text(
                              "Total Deliveries",
                              style: TextStyle(color: Color(0xff00B965)),
                            ),
                            Text(
                              "${driverData!.totalDeliveries}",
                              style: TextStyle(
                                  fontSize: 40, color: Color(0xff00B965)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      elevation: 7,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        child: Column(
                          children: [
                            Text(
                              "Total income",
                              style: TextStyle(color: Color(0xff00B965)),
                            ),
                            Text(
                              "${driverData!.totalIncome}",
                              style: TextStyle(
                                fontSize: 40,
                                color: Color(0xff00B965),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xff009E86),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.selectedIndex = 1;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffE9F7F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Live Order",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF6F8E9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Customer Support",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffE9F7F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Past Orders",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => MoneyDueScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffE9F7F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Money Due",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
