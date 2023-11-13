import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_kitchen/features/auth/screen/auth_screen.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';
import 'package:home_kitchen/screens/user_booked_history.dart';
import 'package:home_kitchen/screens/user_demo_history.dart';
import 'package:home_kitchen/screens/user_see_highlight_screen.dart';
import 'package:home_kitchen/screens/user_seller_near_me.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screen = [
    const UserSeeHighLightScrenn(),
    const UserSellerNearMe(),
  ];
  Position? position;
  List<Placemark>? placemarks;
  List positions = [];
  bool showUI = false;
  getCurrentLocation() async {
    String completeAddress = '';
    Placemark? placemark;
    await Geolocator.requestPermission().whenComplete(() async {
      Position newPos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPos;
      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMark = placemarks![0];
      placemark = pMark;
      completeAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';
    });
    return [
      placemark,
      position!.latitude,
      position!.longitude,
      completeAddress,
    ];
  }

  bool loaded = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      positions = await getCurrentLocation();
      setState(() {
        city = positions[0].locality;
        area = positions[0].subLocality;
        latUser = positions[1];
        lngUser = positions[2];
        completeAddress = positions[3];
        showUI = true;
      });
    });
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Scaffold(
            appBar: loadAppBar(context, _selectedIndex),
            drawer: Drawer(
              child: ListView(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                    ),
                    radius: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Center(
                      child: Text(
                        sharedPreferences!.getString("name")!,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditNameDialog(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text(
                        "Demo food history",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => UserBookedHistory()));
                    }),
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text(
                        "Book food history",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: showUI
                ? BottomNavigationBar(
                    items: [
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.photo_outlined,
                            color: _selectedIndex == 0
                                ? Colors.black
                                : Colors.grey,
                          ),
                          label: 'Highlights',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.near_me_outlined,
                            color: _selectedIndex == 1
                                ? Colors.black
                                : Colors.grey,
                          ),
                          label: 'Sellers Near You',
                        ),
                      ],
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.black,
                    iconSize: 40,
                    onTap: _onItemTapped,
                    elevation: 5)
                : Container(),
            body: showUI ? screen[_selectedIndex] : CircularProgressIndicator(),
          )
        : const CircularProgressIndicator();
  }
}

AppBar loadAppBar(
  BuildContext context,
  int index,
) {
  if (completeAddress == null) {
    return AppBar(
      title: const Text('loading'),
    );
  }
  return AppBar(
    toolbarHeight: 100,
    title: ListTile(
      // leading: const Icon(Icons.location_city),
      title: Row(
        children: [
          Text(
            renderText(index),
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (c) {
                      return AlertDialog(
                        title: Text(completeAddress!),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Back"))
                        ],
                      );
                    });
              },
              icon: Icon(Icons.arrow_drop_down)),
        ],
      ),
      subtitle: Text("Welcome Back, ${sharedPreferences!.getString("name")}!"),
    ),
    actions: [
      TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            GoogleSignIn().signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => const AuthScreen()));
          },
          child: const Text('Log out'))
    ],
  );
}

String renderText(int selectedIndex) {
  if (selectedIndex == 0) {
    return "Home";
  } else if (selectedIndex == 1) {
    return "Seller Near me";
  } else if (selectedIndex == 2) {
    return "Demo History";
  } else {
    return "Book History";
  }
}

Future<void> _showEditNameDialog(BuildContext context) async {
  TextEditingController _nameController = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter the Edited Name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Implement your logic for "Done" button here
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({
                "name": _nameController.text,
              });
              sharedPreferences!.setString("name", _nameController.text);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
            },
            child: Text('Done'),
          ),
        ],
      );
    },
  );
}
