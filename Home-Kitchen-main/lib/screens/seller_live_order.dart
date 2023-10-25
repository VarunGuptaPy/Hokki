import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/models/demo.dart';
import 'package:home_kitchen/screens/seller_ask_for_what_day.dart';
import 'package:home_kitchen/screens/seller_your_day_book.dart';
import 'package:home_kitchen/screens/seller_your_day_demo.dart';
import 'package:intl/intl.dart';

import '../models/bookSeller.dart';
import 'book_user_detail.dart';
import 'demo_user_detail_screen.dart';

class SellerLiveOrder extends StatefulWidget {
  const SellerLiveOrder({super.key});

  @override
  State<SellerLiveOrder> createState() => _SellerLiveOrderState();
}

class _SellerLiveOrderState extends State<SellerLiveOrder> {
  bool isBook = false;
  bool isToday = false;
  String? formattedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Center(
            child: Stack(
              children: isBook == false
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(left: 93.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: const Color(0xffE8E8E8)),
                            onPressed: () => {
                                  setState(() {
                                    isBook = true;
                                  })
                                },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "  Book",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff00B965),
                                ),
                              ),
                            )),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xff2A5A52)),
                        onPressed: () => {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Demo",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xffE8E8E8)),
                        onPressed: () => {
                          setState(() {
                            isBook = false;
                          })
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Demo  ",
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff00B965),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: const Color(0xff2A5A52)),
                            onPressed: () => {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Book",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Stack(
              children: isToday
                  ? [
                      Padding(
                        padding: const EdgeInsets.only(left: 72.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: const Color(0xffE8E8E8)),
                            onPressed: () => {
                                  setState(() {
                                    isToday = false;
                                  })
                                },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "  All Orders",
                                style: TextStyle(
                                  color: Color(0xff00B965),
                                ),
                              ),
                            )),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xff2A5A52)),
                        onPressed: () => {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Today",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xffE8E8E8)),
                        onPressed: () => {
                          setState(() {
                            isToday = true;
                          })
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Today       ",
                            style: TextStyle(
                              color: Color(0xff00B965),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 72.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                backgroundColor: const Color(0xff2A5A52)),
                            onPressed: () => {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "All orders",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ),
                    ],
            ),
          ),
          isBook == false
              ? isToday
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('demo')
                          .where('date', isEqualTo: formattedDate)
                          .where("done", isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Demo demo = Demo.fromMap(
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>);

                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      SellerYourDayDemo(
                                                          demo: demo)));
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')),
                                          title: demo.stage == "cooking"
                                              ? Text(
                                                  '${demo.userName} wanted a demo at ${demo.time} today ')
                                              : demo.stage == "givingMoney"
                                                  ? Text(
                                                      "Your money for order of ${demo.userName} is yet to be arrived by driver")
                                                  : Text(
                                                      "Your demo give to ${demo.userName} is not yet delivered by driver"),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container();
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(
                            FirebaseAuth.instance.currentUser!.uid,
                          )
                          .collection('demo')
                          .where('done', isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Demo? users = Demo.fromMap(
                                      snapshot.data!.docs[index].data()!
                                          as Map<String, dynamic>);
                                  return Padding(
                                    padding: const EdgeInsets.all(20 - .0),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      DemoUserDetailScreen(
                                                        demo: users,
                                                      )));
                                        },
                                        child: ListTile(
                                          leading: const CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                                          ),
                                          title: Text(users.userName),
                                          trailing: Text(users.date),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container();
                      },
                    )
              : isToday
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('book')
                          .where('daysBetween', arrayContains: formattedDate)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  BookSeller demo = BookSeller.fromMap(
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>);
                                  bool day = false;
                                  bool night = false;
                                  if (demo.daysWanted.contains(
                                      DateFormat('EEEE')
                                              .format(DateTime.now())
                                              .toLowerCase() +
                                          'Days')) {
                                    day = true;
                                  }
                                  if (demo.daysWanted.contains(
                                      DateFormat('EEEE')
                                              .format(DateTime.now())
                                              .toLowerCase() +
                                          'Nights')) {
                                    night = true;
                                  }
                                  if (day || night) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        AskForWhatDay(
                                                            bookSeller: demo)));
                                          },
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')),
                                            title: renderTitleBook(
                                                day, night, demo),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                })
                            : Container();
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('book')
                          .where('daysBetween', isNotEqualTo: []).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isNotEmpty) {
                            // totalUser = snapshot.data!.docs.length;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                BookSeller bookSeller = BookSeller.fromMap(
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>);
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(bookSeller.userName)
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) => BookUserDetail(
                                                    bookSeller: bookSeller))),
                                        child: Text('more Info')),
                                  ],
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
        ]),
      ),
    );
  }
}

renderTitleBook(bool day, bool night, BookSeller demo) {
  if (day && !night)
    return Text('you have to give food to ${demo.userName} today at day');
  if (day && night)
    return Text(
        'you have to give food to ${demo.userName} today at day and night');
  if (!day && night)
    return Text('you have to give food to ${demo.userName} today at night');
}
