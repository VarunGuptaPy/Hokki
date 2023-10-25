import 'package:flutter/material.dart';

class SellerRow extends StatelessWidget {
  String day;
  TextEditingController dayController;
  TextEditingController nightController;
  SellerRow({super.key,required this.day,required this.dayController, required this.nightController,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        Text(
                day,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                'Day',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: dayController,
                maxLines: null,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText:
                        'Write the food you will provide in $day at day time'),
              ),
              SizedBox(height: 10,),
              Text(
                'Night',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: nightController,
                maxLines: null,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText:
                        'Write the food you will provide in $day at night time'),
              ),
              SizedBox(height: 30,),
      ],
    );
  }
}