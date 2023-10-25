import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:home_kitchen/global/widgets/menuWidgetEdit.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/splash_screen.dart';

class MenuWidget extends StatefulWidget {
  String day;
  final bool isSeller;
  final bool isView;
  Map<String, dynamic> menu;
  MenuWidget({
    super.key,
    required this.day,
    required this.menu,
    this.isSeller = false,
    this.isView = false,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  List<Widget> mapData(Map<String, dynamic> menu) {
    List<Widget> widgetList = [];
    menu.forEach((key, value) {
      TextEditingController controller = TextEditingController();
      controller.text = menu[key];
      widgetList.add(Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                key,
                textAlign: TextAlign.start,
                softWrap: true,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 25,
              width: MediaQuery.of(context).size.width * 0.50,
              child: TextField(
                readOnly: widget.isView,
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // This adds the border radius
                    borderSide:
                        BorderSide.none, // This makes the border invisible
                  ),
                ),
                controller: controller,
                onChanged: (value) {
                  menu[key] = value;
                },
              ),
            ),
          ],
        ),
      ));
    });
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color(0xff5EFFB6),
        ),
        child: Column(
          children: [
            widget.isSeller
                ? widget.isView
                    ? Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Map<String, dynamic> tempMenu = widget.menu;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => MenuWidgetEdit(
                                        day: widget.day, menu: tempMenu)));
                          },
                          icon: Icon(Icons.edit),
                        ))
                    : Container()
                : Container(),
            Text(
              "${widget.day} day",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mapData(widget.menu["day"]).length,
              itemBuilder: (context, index) {
                return mapData(widget.menu["day"])[index];
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.day} night",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: mapData(widget.menu["night"]).length,
              itemBuilder: (context, index) {
                return mapData(widget.menu["night"])[index];
              },
            ),
            widget.isSeller
                ? widget.isView == false
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController columnNameController =
                                    TextEditingController();
                                return AlertDialog(
                                  title: Text(
                                    "enter the name of column",
                                    textAlign: TextAlign.center,
                                  ),
                                  content: TextField(
                                    controller: columnNameController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (columnNameController.text.trim() !=
                                            "") {
                                          setState(() {
                                            widget.menu["day"][
                                                columnNameController.text] = "";
                                            widget.menu["night"][
                                                columnNameController.text] = "";
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text("Done"),
                                    ),
                                  ],
                                );
                              });
                        },
                        child:
                            Text("+Add Column", style: TextStyle(fontSize: 18)))
                    : Container()
                : Container()
          ],
        ),
      ),
    );
  }
}
