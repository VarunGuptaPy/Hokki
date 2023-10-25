import 'package:flutter/material.dart';
import 'package:home_kitchen/global/widgets/checkboxAddons.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';
import 'package:home_kitchen/models/item.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/screens/user_place_order_for_one_day_2.dart';
import 'package:intl/intl.dart';

import '../global/widgets/status.dart';

class UserPlaceOrderForOneDay extends StatefulWidget {
  Seller seller;
  Item item;
  double? deliveryPrice;
  UserPlaceOrderForOneDay(
      {super.key,
      required this.seller,
      required this.item,
      this.deliveryPrice});

  @override
  State<UserPlaceOrderForOneDay> createState() =>
      _UserPlaceOrderForOneDayState();
}

class _UserPlaceOrderForOneDayState extends State<UserPlaceOrderForOneDay> {
  DateTime? pickedDate;
  String? formattedDate = "";
  String selectedValues = 'Day';
  List<DropdownMenuItem> menuItems = [
    const DropdownMenuItem(
      value: 'Day',
      child: Text('Day'),
    ),
    const DropdownMenuItem(
      value: 'Night',
      child: Text('Night'),
    ),
  ];
  List addonsSelected = [];
  List totalAddons = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalAddons = widget.item.addons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'For which day you want Demo of Food',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Date :',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        formattedDate!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(DateTime.now().year + 1));
                            formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate!);
                            setState(() {
                              pickedDate;
                              formattedDate;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff009E86),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select time :',
                            style: TextStyle(fontSize: 20),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                          value: selectedValues,
                          items: menuItems,
                          onChanged: (item) {
                            setState(() {
                              selectedValues = item;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  totalAddons.isEmpty
                      ? Container()
                      : const Text(
                          'Addons: ',
                          style: TextStyle(fontSize: 20),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  totalAddons.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: totalAddons.length,
                            itemBuilder: (context, index) {
                              return Material(
                                elevation: 5,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: CheckboxAddons(
                                    price: totalAddons[index]['price'],
                                    selectedAddons: addonsSelected,
                                    totalAddons: totalAddons,
                                    item: totalAddons[index]['item']),
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
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
                            if (formattedDate != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      UserPlaceOrderForOneDayStep2(
                                        item: widget.item,
                                        selectedAddons: addonsSelected,
                                        seller: widget.seller,
                                        date: formattedDate!,
                                        deliveryPrice: widget.deliveryPrice!,
                                        time: selectedValues,
                                      )),
                                ),
                              );
                            } else {
                              showSnackBar(
                                  context, 'Please give required field');
                            }
                          },
                          child: const Text(
                            'Proceed',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
