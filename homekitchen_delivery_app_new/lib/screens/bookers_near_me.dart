import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';
import 'package:homekitchen_delivery_app_new/models/DriverRequestBook.dart';
import 'package:homekitchen_delivery_app_new/widgets/slider_dialog.dart';

class BookersNearME extends StatefulWidget {
  const BookersNearME({super.key});

  @override
  State<BookersNearME> createState() => _BookersNearMEState();
}

class _BookersNearMEState extends State<BookersNearME> {
  double? maxDistanceBetweenSellerAndUser = 2;
  double? maxDistanceBetweenSellerAndDriver = 2;
  bool showUI = false;
  Placemark? placemark;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      positions = await getCurrentLocation();
      placemark = positions[0];
    });
    FirebaseFirestore.instance
        .collection("importantData")
        .doc("importantData")
        .get()
        .then((value) {
      showDialog(
          context: context,
          builder: (c) => SliderDialog(
                title: "Distance between seller and user",
                writeBeforeValue: "Distance in km",
                onCancel: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (c) => SliderDialog(
                            title: "Distance between you and seller",
                            writeBeforeValue: "Distance in km",
                            onCancel: () {
                              setState(() {
                                showUI = true;
                              });
                              Navigator.pop(context);
                            },
                            onDone: (number) {
                              setState(() {
                                showUI = true;
                              });
                              Navigator.pop(context);
                              maxDistanceBetweenSellerAndDriver = number;
                            },
                            max: 5,
                            min: 1,
                            diversion: 8,
                            showDeliverPrice: false,
                            deliveryPrice: value.data()!["costPerKm"],
                          ));
                },
                onDone: (number) {
                  maxDistanceBetweenSellerAndUser = number;
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (c) => SliderDialog(
                            title: "Distance between you and seller",
                            writeBeforeValue: "Distance in km",
                            onCancel: () {
                              setState(() {
                                showUI = true;
                              });
                              Navigator.pop(context);
                            },
                            onDone: (number) {
                              setState(() {
                                showUI = true;
                                maxDistanceBetweenSellerAndDriver = number;
                              });
                              Navigator.pop(context);
                            },
                            max: 5,
                            min: 1,
                            diversion: 8,
                            showDeliverPrice: false,
                            deliveryPrice: value.data()!["costPerKm"],
                          ));
                },
                max: 5,
                min: 1,
                diversion: 8,
                showDeliverPrice: true,
                deliveryPrice: value.data()!["costPerKm"],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showUI
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("driverRequest")
                  .where("orderType", isEqualTo: "book")
                  .where("city", isEqualTo: driverData!.city)
                  .where("accepted", isEqualTo: false)
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
                          double distanceBetween = Geolocator.distanceBetween(
                                  positions[1],
                                  positions[2],
                                  driverRequestBook.sellerLat,
                                  driverRequestBook.sellerLng) /
                              1000;
                          double distanceBetweenSellerAndUser =
                              Geolocator.distanceBetween(
                                      driverRequestBook.sellerLat,
                                      driverRequestBook.sellerLng,
                                      driverRequestBook.userLat,
                                      driverRequestBook.userlng) /
                                  1000;
                          if (distanceBetween <=
                              maxDistanceBetweenSellerAndDriver!) {
                            if (distanceBetweenSellerAndUser <=
                                maxDistanceBetweenSellerAndUser!) {
                              // return Padding(
                              //   padding: const EdgeInsets.all(20.0),
                              //   child: Material(
                              //     borderRadius: const BorderRadius.all(
                              //       Radius.circular(25),
                              //     ),
                              //     elevation: 5,
                              //     child: Column(
                              //       children: [
                              //         Center(
                              //           child: Text(
                              //             'Delivery Cost : ${driverRequestBook.deliveryPrice}',
                              //           ),
                              //         ),
                              //         ListTile(
                              //           leading: CircleAvatar(
                              //             backgroundImage: NetworkImage(
                              //                 driverRequestBook
                              //                     .sellerProfilePic),
                              //           ),
                              //           title:
                              //               Text(driverRequestBook.sellerName),
                              //           subtitle: Text(
                              //               "distance from you to seller: ${distanceBetween.toStringAsFixed(2)}"),
                              //         ),
                              //         Container(
                              //           height: 1,
                              //           decoration: const BoxDecoration(
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //         ListTile(
                              //           leading: const CircleAvatar(
                              //             backgroundImage: NetworkImage(
                              //                 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                              //           ),
                              //           title: Text(driverRequestBook.userName),
                              //           subtitle: Text(
                              //               "Distance from seller to user: ${distanceBetweenSellerAndUser.toStringAsFixed(2)}"),
                              //         ),
                              //         Center(
                              //           child: ElevatedButton(
                              //             child: const Text("Accept"),
                              //             onPressed: () async {
                              //               await FirebaseFirestore.instance
                              //                   .collection("driverRequest")
                              //                   .doc(driverRequestBook.id)
                              //                   .update({
                              //                 "driverUID": FirebaseAuth
                              //                     .instance.currentUser!.uid,
                              //                 "accepted": true,
                              //               });
                              // FirebaseFirestore.instance
                              //     .collection("driverRequest")
                              //     .doc(driverRequestBook.id)
                              //     .get()
                              //     .then((value) async {
                              //   DriverRequestBook
                              //       driverRequestBook2 =
                              //       DriverRequestBook.fromMap(
                              //           value.data()!);
                              //   await FirebaseFirestore.instance
                              //       .collection("Driver")
                              //       .doc(FirebaseAuth.instance
                              //           .currentUser!.uid)
                              //       .collection("book")
                              //       .doc(driverRequestBook2.id)
                              //       .set(driverRequestBook2
                              //           .toMap());
                              //   await FirebaseFirestore.instance
                              //       .collection("users")
                              //       .doc(driverRequestBook2
                              //           .userUID)
                              //       .collection("orders")
                              //       .doc(driverRequestBook2.id)
                              //       .update({
                              //     "driverUID": FirebaseAuth
                              //         .instance.currentUser!.uid,
                              //   });
                              //   await FirebaseFirestore.instance
                              //       .collection("users")
                              //       .doc(driverRequestBook2
                              //           .sellerUID)
                              //       .collection("orders")
                              //       .doc(driverRequestBook2.id)
                              //       .update({
                              //     "driverUID": FirebaseAuth
                              //         .instance.currentUser!.uid,
                              //   });
                              // });
                              // await FirebaseFirestore.instance
                              //     .collection("driverRequest")
                              //     .doc(driverRequest.id)
                              //     .update({
                              //   "accepted": true,
                              //   "stage": "toSeller"
                              // });
                              // DriverRequest? driverRequest2;
                              // await FirebaseFirestore.instance
                              //     .collection("driverRequest")
                              //     .doc(driverRequest.id)
                              //     .get()
                              //     .then((value) {
                              //   driverRequest2 = DriverRequest.fromJson(
                              //       value.data()!);
                              // });
                              // await FirebaseFirestore.instance
                              //     .collection("users")
                              //     .doc(driverRequest2!.sellerUID)
                              //     .collection("demo")
                              //     .doc(driverRequest2!.id)
                              //     .update({"stage": "out for order"});
                              // await FirebaseFirestore.instance
                              //     .collection("users")
                              //     .doc(driverRequest2!.userUID)
                              //     .collection("orders")
                              //     .doc(driverRequest2!.id)
                              //     .update({"stage": "out for order"});
                              // await FirebaseFirestore.instance
                              //     .collection("Driver")
                              //     .doc(FirebaseAuth
                              //         .instance.currentUser!.uid)
                              //     .collection("deliveries")
                              //     .doc(driverRequest.id)
                              //     .set(driverRequest2!.toJson());
                              //             },
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // );
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Material(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                          child: Text(
                                        "Delivery Price:  ₹${driverRequestBook.deliveryPrice}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      )),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Material(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(13)),
                                          elevation: 5,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  driverRequestBook
                                                      .sellerProfilePic),
                                            ),
                                            title: Text(
                                              driverRequestBook.sellerName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              "Distance between you and seller: ${distanceBetween.toStringAsFixed(2)}Km",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Material(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(13)),
                                          elevation: 5,
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                                            ),
                                            title: Text(
                                              driverRequestBook.userName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              "Distance between seller and user: ${distanceBetweenSellerAndUser.toStringAsFixed(2)}Km",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xff2A5A52),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                Radius.circular(5),
                                              ))),
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection("driverRequest")
                                                .doc(driverRequestBook.id)
                                                .get()
                                                .then((value) async {
                                              DriverRequestBook
                                                  driverRequestBook2 =
                                                  DriverRequestBook.fromMap(
                                                      value.data()!);
                                              FirebaseFirestore.instance
                                                  .collection("Driver")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection("book")
                                                  .doc(driverRequestBook2.id)
                                                  .set(driverRequestBook2
                                                      .toMap());
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(driverRequestBook2
                                                      .userUID)
                                                  .collection("orders")
                                                  .doc(driverRequestBook2.id)
                                                  .update({
                                                "driverUID": FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(driverRequestBook2
                                                      .sellerUID)
                                                  .collection("orders")
                                                  .doc(driverRequestBook2.id)
                                                  .update({
                                                "driverUID": FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              });
                                              FirebaseFirestore.instance
                                                  .collection("driverRequest")
                                                  .doc(driverRequestBook2.id)
                                                  .update({
                                                "accepted": true,
                                                "driverUID": FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              });
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                      // ListTile(
                                      //   leading: CircleAvatar(
                                      //     backgroundImage: NetworkImage(
                                      //         driverRequest.sellerProfilePic),
                                      //   ),
                                      //   title: Text(driverRequest.sellerName),
                                      //   subtitle: Text(
                                      //       "distance from you to seller: ${distanceBetween.toStringAsFixed(2)}"),
                                      // ),
                                      // Container(
                                      //   height: 1,
                                      //   decoration: const BoxDecoration(
                                      //     color: Colors.black,
                                      //   ),
                                      // ),
                                      // ListTile(
                                      //   leading: const CircleAvatar(
                                      //     backgroundImage: NetworkImage(
                                      //         'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                      //   ),
                                      //   title: Text(driverRequest.userName),
                                      //   subtitle: Text(
                                      //       "Distance from seller to user: ${distanceBetweenSellerAndUser.toStringAsFixed(2)}"),
                                      // ),
                                      // Center(
                                      //   child: ElevatedButton(
                                      //     child: const Text("Accept"),
                                      //     onPressed: () async {
                                      // await FirebaseFirestore.instance
                                      //     .collection("driverRequest")
                                      //     .doc(driverRequest.id)
                                      //     .update({
                                      //   "accepted": true,
                                      //   "stage": "toSeller"
                                      // });
                                      // DriverRequest? driverRequest2;
                                      // await FirebaseFirestore.instance
                                      //     .collection("driverRequest")
                                      //     .doc(driverRequest.id)
                                      //     .get()
                                      //     .then((value) {
                                      //   driverRequest2 =
                                      //       DriverRequest.fromJson(
                                      //           value.data()!);
                                      // });
                                      // await FirebaseFirestore.instance
                                      //     .collection("users")
                                      //     .doc(driverRequest2!.sellerUID)
                                      //     .collection("demo")
                                      //     .doc(driverRequest2!.id)
                                      //     .update(
                                      //         {"stage": "out for order"});
                                      // await FirebaseFirestore.instance
                                      //     .collection("users")
                                      //     .doc(driverRequest2!.userUID)
                                      //     .collection("orders")
                                      //     .doc(driverRequest2!.id)
                                      //     .update(
                                      //         {"stage": "out for order"});
                                      // await FirebaseFirestore.instance
                                      //     .collection("Driver")
                                      //     .doc(FirebaseAuth
                                      //         .instance.currentUser!.uid)
                                      //     .collection("deliveries")
                                      //     .doc(driverRequest.id)
                                      //     .set(driverRequest2!.toJson());
                                      //     },
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                          return Container();
                        },
                      )
                    : Container();
              },
            )
          : Container(),
    );
  }
}
