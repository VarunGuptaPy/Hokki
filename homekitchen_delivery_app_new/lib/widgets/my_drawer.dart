import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/globals.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(driverData!.profilePic),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
