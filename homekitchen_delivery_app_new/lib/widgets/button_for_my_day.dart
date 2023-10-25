import 'package:flutter/material.dart';

Widget ButtonForMyDay(
    {required void Function() onPressed,
    required String text,
    required BuildContext context}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.5,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff2A5A52),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(8),
          ))),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}
