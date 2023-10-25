import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  List<String> DaysWanted;
  List<String> DaysNotWanted;
  String title;
  String value;
  bool Information;
  CheckboxWidget(
      {required this.value,
      required this.DaysWanted,
      required this.DaysNotWanted,
      super.key,
      required this.title,
      required this.Information});
  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff009E86),
        child: CheckboxListTile(
          activeColor: Color(0xff009E86),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          value: widget.Information,
          onChanged: (value) {
            setState(() {
              if (value! == false) {
                widget.DaysWanted.remove(widget.value);
                widget.DaysNotWanted.add(widget.value);
              } else {
                widget.DaysNotWanted.remove(widget.value);
                widget.DaysWanted.add(widget.value);
              }
              widget.Information = value;
            });
          },
        ),
      ),
    );
  }
}
