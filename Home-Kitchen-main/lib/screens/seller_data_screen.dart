import 'package:flutter/material.dart';
import 'package:home_kitchen/features/seller_menu/screens/seller_menu_sceeen.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/seller_live_order.dart';

class SellerDataScreen extends StatefulWidget {
  const SellerDataScreen({super.key});

  @override
  State<SellerDataScreen> createState() => _SellerDataScreenState();
}

class _SellerDataScreenState extends State<SellerDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  elevation: 7,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          "User Under Me",
                          style: TextStyle(color: Color(0xff00B965)),
                        ),
                        Text(
                          "${sellerData!.userUnderMe}",
                          style:
                              TextStyle(fontSize: 40, color: Color(0xff00B965)),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  elevation: 7,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          "Total Income",
                          style: TextStyle(color: Color(0xff00B965)),
                        ),
                        Text(
                          "${sellerData!.unWidraw}",
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
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => SellerMenuScreen()));
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff5EFFB6),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Menu",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => SellerLiveOrder()));
                  },
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Material(
                      color: Color(0xff5EFFB6),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Live Order",
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff5EFFB6),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Customer Support",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Material(
                    color: Color(0xff5EFFB6),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Redeem Money",
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
