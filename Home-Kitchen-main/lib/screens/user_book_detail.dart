import 'package:flutter/material.dart';
import 'package:home_kitchen/models/userBook.dart';

class UserBookDetail extends StatefulWidget {
  UserBook userBook;
  UserBookDetail({super.key, required this.userBook});

  @override
  State<UserBookDetail> createState() => _UserBookDetailState();
}

class _UserBookDetailState extends State<UserBookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Book Detail",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    )),
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(widget.userBook.sellerPhoto),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.userBook.sellerName,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Text(
                    'Start Date:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    widget.userBook.startDate,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    'End Date:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    widget.userBook.endDate,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    'Food Price:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    "₹${widget.userBook.foodPrice.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    'Addons Price:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    "₹${widget.userBook.addonsPrice.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    "₹${widget.userBook.price.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
