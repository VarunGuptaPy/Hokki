import 'package:flutter/material.dart';
import 'package:home_kitchen/global/widgets/checkboxWidgets.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/screens/user_book_seller_3.dart';
import 'package:intl/intl.dart';

import '../global/widgets/checkboxAddons.dart';
import '../models/item.dart';

class UserBookSeller extends StatefulWidget {
  Seller? seller;
  Item item;
  double? deliveryPrice;
  UserBookSeller(
      {super.key,
      required this.deliveryPrice,
      required this.seller,
      required this.item});

  @override
  State<UserBookSeller> createState() => _UserBookSellerState();
}

class _UserBookSellerState extends State<UserBookSeller> {
  DateTime? timeStarted;
  DateTime? timeEnded;
  bool mondayDays = true;
  bool tuesdayDays = true;
  bool wednesdayDays = true;
  bool thursdayDays = true;
  bool fridayDays = true;
  bool saturdayDays = true;
  bool sundayDays = true;
  bool mondayNights = true;
  bool tuesdayNights = true;
  bool wednesdayNights = true;
  bool thursdayNights = true;
  bool fridayNights = true;
  bool saturdayNights = true;
  bool sundayNights = true;
  List<String> daysWanted = [
    'mondayDays',
    'tuesdayDays',
    'wednesdayDays',
    'thursdayDays',
    'fridayDays',
    'saturdayDays',
    'sundayDays',
    'mondayNights',
    'tuesdayNights',
    'wednesdayNights',
    'thursdayNights',
    'fridayNights',
    'saturdayNights',
    'sundayNights',
  ];
  List<String> DaysNotWanted = [];
  List addonsSelected = [];
  List totalAddons = [];
  @override
  void initState() {
    super.initState();
    totalAddons = widget.item.addons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Seller'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    'Some Details',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Date Begining'),
                            const SizedBox(
                              width: 30,
                            ),
                            timeStarted != null
                                ? Text(
                                    "${DateFormat('yyyy-MM-dd').format(timeStarted!)}  ",
                                  )
                                : Container(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2A5A52),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  timeStarted = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate:
                                          DateTime(DateTime.now().year + 1));
                                  setState(() {
                                    timeStarted;
                                  });
                                },
                                child: const Text(
                                  'Select Date',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Date Ending'),
                            const SizedBox(
                              width: 30,
                            ),
                            timeEnded != null
                                ? Text(
                                    "${DateFormat('yyyy-MM-dd').format(timeEnded!)}   ",
                                  )
                                : Container(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff2A5A52),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  timeEnded = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2099));
                                  setState(() {
                                    timeEnded;
                                  });
                                },
                                child: const Text(
                                  'Select Date',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Uncheck the day you don\'t want food',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      )),
                  CheckboxWidget(
                      value: 'mondayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Monday Day',
                      Information: fridayDays),
                  CheckboxWidget(
                      value: 'mondayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Monday Night',
                      Information: fridayNights),
                  CheckboxWidget(
                      value: 'tuesdayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Tuesday Day',
                      Information: mondayDays),
                  CheckboxWidget(
                      value: 'tuesdayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Tuesday Night',
                      Information: mondayNights),
                  CheckboxWidget(
                      value: 'wednesdayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Wednesday Day',
                      Information: tuesdayDays),
                  CheckboxWidget(
                      value: 'wednesdayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Wednesday Night',
                      Information: tuesdayNights),
                  CheckboxWidget(
                      value: 'thursdayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Thursday Day',
                      Information: wednesdayDays),
                  CheckboxWidget(
                      value: 'thursdayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Thursday Night',
                      Information: wednesdayNights),
                  CheckboxWidget(
                      value: 'fridayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'friday Day',
                      Information: thursdayDays),
                  CheckboxWidget(
                      value: 'fridayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'friday Night',
                      Information: thursdayNights),
                  CheckboxWidget(
                      value: 'saturdayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Saturday Day',
                      Information: saturdayDays),
                  CheckboxWidget(
                      value: 'saturdayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Saturday Night',
                      Information: saturdayNights),
                  CheckboxWidget(
                      value: 'sundayDays',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Sunday Day',
                      Information: sundayDays),
                  CheckboxWidget(
                      value: 'sundayNights',
                      DaysWanted: daysWanted,
                      DaysNotWanted: DaysNotWanted,
                      title: 'Sunday Night',
                      Information: sundayNights),
                  const SizedBox(
                    height: 20,
                  ),
                  totalAddons.isEmpty
                      ? Container()
                      : const Text(
                          'Addons',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  totalAddons.isEmpty
                      ? Container()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: totalAddons.length,
                          itemBuilder: (context, index) {
                            return CheckboxAddons(
                                price: totalAddons[index]['price'],
                                selectedAddons: addonsSelected,
                                totalAddons: totalAddons,
                                item: totalAddons[index]['item']);
                          },
                        ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.86,
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => UserBookSeller3(
                      //           item: widget.item,
                      //           selectedAddons: addonsSelected,
                      //           seller: widget.seller,
                      //           difference:
                      //               timeEnded!.difference(timeStarted!).inDays,
                      //           DaysWanted: daysWanted,
                      //           DaysNotWanted: DaysNotWanted,
                      //           dayStart:
                      //               DateFormat('yyyy-MM-dd').format(timeStarted!),
                      //           dayEnd:
                      //               DateFormat('yyyy-MM-dd').format(timeEnded!),
                      //           timeStarted: timeStarted,
                      //           timeEnded: timeEnded),
                      //     ));
                      if (timeEnded != null && timeStarted != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => UserBookSeller2(
                                      deliveryPrice: widget.deliveryPrice!,
                                      item: widget.item,
                                      addonsSelected: addonsSelected,
                                      timeStarted: timeStarted,
                                      timeEnded: timeEnded,
                                      seller: widget.seller!,
                                      difference: timeEnded!
                                          .difference(timeStarted!)
                                          .inDays,
                                      DaysWanted: daysWanted,
                                      DaysNotWanted: DaysNotWanted,
                                      dayStart: DateFormat('yyyy-MM-dd')
                                          .format(timeStarted!),
                                      dayEnd: DateFormat('yyyy-MM-dd')
                                          .format(timeEnded!),
                                      paymentWay: 'daily',
                                    )));
                      }
                    },
                    child: const Text('Proceed',
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
