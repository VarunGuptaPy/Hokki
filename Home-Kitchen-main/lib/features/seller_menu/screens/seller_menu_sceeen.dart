import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_kitchen/features/seller_menu/repository/seller_item_add_repository.dart';
import 'package:home_kitchen/global/widgets/menuWidget.dart';
import 'package:home_kitchen/global/widgets/seller_row.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/models/item.dart';
import 'package:home_kitchen/screens/splash_screen.dart';

class SellerMenuScreen extends ConsumerStatefulWidget {
  const SellerMenuScreen({super.key});

  @override
  ConsumerState<SellerMenuScreen> createState() => _SellerItemAddScreenState();
}

class _SellerItemAddScreenState extends ConsumerState<SellerMenuScreen> {
  TextEditingController ChipTextController = TextEditingController();
  TextEditingController ChipPriceController = TextEditingController();
  TextEditingController OneDayPriceController = TextEditingController();
  List<Map<String, String>> ChipText = [];

  List<Chip> Chips = [];
  bool hasData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .doc("item")
          .get()
          .then((value) {
        if (value.exists) {
          final data = value.data()!;
          Item item = Item.fromMap(data);
          setState(() {
            hasData = true;
            Monday = item.Monday;
            Tuesday = item.Tuesday;
            Wednesday = item.Wednesday;
            Thursday = item.Thursday;
            Friday = item.Friday;
            Saturday = item.Saturday;
            Sunday = item.Sunday;
            ChipTexts = item.addons;
            price = item.price;
            checked = true;
          });
        }
      });
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc("item")
        .get()
        .then((value) {
      if (value.exists) {
        final data = value.data()!;
        Item item = Item.fromMap(data);
        setState(() {
          hasData = true;
          Monday = item.Monday;
          Tuesday = item.Tuesday;
          Wednesday = item.Wednesday;
          Thursday = item.Thursday;
          Friday = item.Friday;
          Saturday = item.Saturday;
          Sunday = item.Sunday;
          ChipTexts = item.addons;
          price = item.price;
          checked = true;
        });
      }
    });
  }

  TextEditingController changeController = TextEditingController();
  void change(String field) {
    showDialog(
        context: context,
        builder: (c) => AlertDialog(
              content: TextField(
                controller: changeController,
                maxLines: null,
                textAlign: TextAlign.center,
                decoration:
                    const InputDecoration(hintText: 'Write the changing text'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (changeController.text.trim().isNotEmpty) {
                        if (field == 'price') {
                          if (int.parse(price) <=
                              int.parse(changeController.text)) {
                            if (totalUser != 0) {
                              showSnackBar(context,
                                  "you can't increase the price when you have any user booked");
                            } else {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('items')
                                  .doc('item')
                                  .update({
                                field: changeController.text,
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => const SplashScreen()));
                            }
                          } else {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('items')
                                .doc('item')
                                .update({
                              field: changeController.text,
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const SplashScreen()));
                          }
                        } else {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('items')
                              .doc('item')
                              .update({
                            field: changeController.text,
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const SplashScreen()));
                        }
                      }
                    },
                    child: const Text('Submit'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: checked == false
          ? SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuWidget(
                      day: "Monday",
                      menu: menu["Monday"],
                      isSeller: true,
                    ),
                    MenuWidget(
                      day: "Tuesday",
                      menu: menu["Tuesday"],
                      isSeller: true,
                    ),
                    MenuWidget(
                      day: "Wednesday",
                      menu: menu["Wednesday"],
                      isSeller: true,
                    ),
                    MenuWidget(
                      day: "Thursday",
                      menu: menu["Thursday"],
                      isSeller: true,
                    ),
                    MenuWidget(
                      day: "Friday",
                      menu: menu["Friday"],
                      isSeller: true,
                    ),
                    MenuWidget(
                      day: "Saturday",
                      menu: menu["Saturday"],
                      isSeller: true,
                    ),
                    MenuWidget(
                      day: "Sunday",
                      menu: menu["Sunday"],
                      isSeller: true,
                    ),
                    const Text(
                      'Price for one day one time',
                      style: TextStyle(fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: OneDayPriceController,
                      ),
                    ),
                    const Text(
                      'Add Ons',
                      style: TextStyle(fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 270,
                            child: TextField(
                              controller: ChipTextController,
                              decoration:
                                  const InputDecoration(hintText: 'Add adons'),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 40,
                            child: TextField(
                                controller: ChipPriceController,
                                decoration: const InputDecoration(
                                  hintText: 'price',
                                )),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (ChipPriceController.text != '' &&
                                  ChipTextController.text != '') {
                                setState(() {
                                  ChipText.add({
                                    'item': ChipTextController.text,
                                    'price': ChipPriceController.text
                                  });
                                  Chips.add(
                                    Chip(
                                      label: Text(
                                        ChipTextController.text,
                                      ),
                                      onDeleted: () {
                                        setState(
                                          () {
                                            Chips.removeAt(ChipText.length - 1);
                                            ChipText.removeAt(
                                                ChipText.length - 1);
                                          },
                                        );
                                        ChipTextController.text = '';
                                      },
                                      avatar:
                                          Text('₹${ChipPriceController.text}'),
                                    ),
                                  );
                                });
                              }
                            },
                            icon: const Icon(Icons.check))
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Chips[index];
                      },
                      itemCount: Chips.length,
                    ),
                    TextButton(
                        onPressed: () {
                          if (OneDayPriceController.text.trim().isNotEmpty) {
                            ref
                                .watch(sellerItemAddScreenRepositoryProvider)
                                .saveItemToDatabase(
                                  Monday: menu["Monday"],
                                  Tuesday: menu["Tuesday"],
                                  Wednesday: menu["Wednesday"],
                                  Thursday: menu["Thursday"],
                                  Friday: menu["Friday"],
                                  Saturday: menu["Saturday"],
                                  Sunday: menu["Sunday"],
                                  addons: ChipText,
                                  price: OneDayPriceController.text,
                                );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const SplashScreen()));
                          } else {
                            showSnackBar(context, 'please fill all the column');
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ))
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Text(
                      "Your Menu Has Been Created",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        MenuWidget(
                            day: "Monday",
                            menu: Monday,
                            isSeller: true,
                            isView: true),
                        MenuWidget(
                            day: "Tuesday",
                            menu: Tuesday,
                            isSeller: true,
                            isView: true),
                        MenuWidget(
                          day: "Wednesday",
                          menu: Wednesday,
                          isSeller: true,
                          isView: true,
                        ),
                        MenuWidget(
                            day: "Thursday",
                            menu: Thursday,
                            isSeller: true,
                            isView: true),
                        MenuWidget(
                            day: "Friday",
                            menu: Friday,
                            isSeller: true,
                            isView: true),
                        MenuWidget(
                            day: "Saturday",
                            menu: Saturday,
                            isSeller: true,
                            isView: true),
                        MenuWidget(
                            day: "Sunday",
                            menu: Sunday,
                            isSeller: true,
                            isView: true),
                      ],
                    ),
                    const Text(
                      'Price for one day one time',
                      style: TextStyle(fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₹$price',
                          style: const TextStyle(fontSize: 40),
                        ),
                        IconButton(
                            onPressed: () {
                              change('price');
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                    const Text(
                      'Addons',
                      style: TextStyle(fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: TextField(
                                controller: ChipTextController,
                                decoration: const InputDecoration(
                                    hintText: 'Add adons'),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 40,
                              child: TextField(
                                  controller: ChipPriceController,
                                  decoration: const InputDecoration(
                                    hintText: 'price',
                                  )),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (ChipPriceController.text != '' &&
                                    ChipTextController.text != '') {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('items')
                                      .doc('item')
                                      .update({
                                    'addons': FieldValue.arrayUnion([
                                      {
                                        'item': ChipTextController.text,
                                        'price': ChipPriceController.text
                                      }
                                    ])
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SplashScreen(),
                                      ));
                                }
                              },
                              icon: const Icon(Icons.check))
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: ChipTexts.length,
                      itemBuilder: (context, index) {
                        return Chip(
                          label: Text(ChipTexts[index]['item']),
                          avatar: Text('₹${ChipTexts[index]['price']}'),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
