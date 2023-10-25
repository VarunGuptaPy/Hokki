import 'package:flutter/material.dart';
import 'package:home_kitchen/globals.dart';

class CheckboxAddons extends StatefulWidget {
  List totalAddons;
  String price;
  List selectedAddons;
  String item;
  CheckboxAddons(
      {super.key,
      required this.price,
      required this.selectedAddons,
      required this.totalAddons,
      required this.item});

  @override
  State<CheckboxAddons> createState() => _CheckboxAddonsState();
}

class _CheckboxAddonsState extends State<CheckboxAddons> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // CheckboxListTile(
        //   value: value,
        //   title: Text('${widget.item}    ${widget.price}'),

        // ),
        Text(
          widget.item,
          style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w800),
        ),
        Text(
          widget.price,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Checkbox(
          value: value,
          activeColor: Colors.white,
          checkColor: Colors.black,
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(width: 2.0, color: Colors.black),
          ),
          onChanged: (v) {
            setState(() {
              value = v!;
              if (v) {
                widget.totalAddons.remove({
                  'item': widget.item,
                  'price': widget.price,
                });
                widget.selectedAddons.add({
                  'item': widget.item,
                  'price': widget.price,
                });
              } else {
                widget.totalAddons.add({
                  'item': widget.item,
                  'price': widget.price,
                });
                widget.selectedAddons.remove({
                  'item': widget.item,
                  'price': widget.price,
                });
              }
            });
          },
        ),
      ],
    );
  }
}
