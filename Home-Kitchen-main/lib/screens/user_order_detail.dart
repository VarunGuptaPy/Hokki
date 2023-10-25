import 'package:flutter/material.dart';
import 'package:home_kitchen/models/userDemo.dart';

class UserOrderDetail extends StatefulWidget {
  UserDemo userDemo;
  UserOrderDetail({super.key, required this.userDemo});

  @override
  State<UserOrderDetail> createState() => _UserOrderDetailState();
}

class _UserOrderDetailState extends State<UserOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Order Details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(widget.userDemo.sellerPhoto),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.userDemo.sellerName,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    'Done:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: widget.userDemo.done
                      ? Text(
                          'Yes',
                          style: TextStyle(fontSize: 20),
                        )
                      : Text(
                          'No',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text('Date:', style: TextStyle(fontSize: 20)),
                  trailing: Text(widget.userDemo.date,
                      style: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text('Food Price:', style: TextStyle(fontSize: 20)),
                  trailing: Text(widget.userDemo.foodprice,
                      style: TextStyle(fontSize: 20)),
                ),
                widget.userDemo.addonsPrice == 0
                    ? SizedBox(
                        height: 20,
                      )
                    : Container(),
                widget.userDemo.addonsPrice == 0
                    ? ListTile(
                        title: Text('Addons Price:',
                            style: TextStyle(fontSize: 20)),
                        trailing: Text(widget.userDemo.addonsPrice,
                            style: TextStyle(fontSize: 20)),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text('Total Price:', style: TextStyle(fontSize: 20)),
                  trailing: Text(widget.userDemo.totalPrice,
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
