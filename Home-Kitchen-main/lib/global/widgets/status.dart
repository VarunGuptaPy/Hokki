import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  int? index;
  Status({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "Information",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            CircleAvatar(
              backgroundColor:
                  index == 0 ? Color(0xff009E86) : Color(0xffD9D9D9),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 4,
          color: Colors.black,
        ),
        Column(
          children: [
            Text(
              "Address",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            CircleAvatar(
              backgroundColor:
                  index == 1 ? Color(0xff009E86) : Color(0xffD9D9D9),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 4,
          color: Colors.black,
        ),
        Column(
          children: [
            Text(
              "done",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            CircleAvatar(
              backgroundColor:
                  index == 2 ? Color(0xff009E86) : Color(0xffD9D9D9),
            ),
          ],
        ),
      ],
    );
  }
}
