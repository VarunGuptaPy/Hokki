import 'package:flutter/material.dart';
import 'package:home_kitchen/screens/seller_your_day_book.dart';

import '../models/bookSeller.dart';

class AskForWhatDay extends StatefulWidget {
  BookSeller? bookSeller;
  AskForWhatDay({this.bookSeller});

  @override
  State<AskForWhatDay> createState() => _AskForWhatDayState();
}

class _AskForWhatDayState extends State<AskForWhatDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "For what time?",
                style: TextStyle(
                  fontSize: 35,
                  // color: Color(0xff00B965),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset("assets/images/DayAndNight.png"),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => SellerYourDayBook(
                                  bookSeller: widget.bookSeller!,
                                  time: "D",
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xffA1D1E7)),
                  child: Row(
                    children: [
                      Image.asset("assets/images/sun.png"),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Day Time",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => SellerYourDayBook(
                                  bookSeller: widget.bookSeller!,
                                  time: "N",
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xff293A42)),
                  child: Row(
                    children: [
                      Image.asset("assets/images/moon.png"),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Night Time",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
