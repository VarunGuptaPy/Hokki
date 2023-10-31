import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_kitchen/features/auth/screen/auth_screen.dart';
import 'package:home_kitchen/globals.dart';
import 'package:home_kitchen/screens/user_booked_history.dart';
import 'package:home_kitchen/screens/user_demo_history.dart';
import 'package:home_kitchen/screens/user_see_highlight_screen.dart';
import 'package:home_kitchen/screens/user_seller_near_me.dart';

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
    UserDemoHistory(),
    UserBookedHistory(),
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
                          label: '⇑',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.near_me_outlined,
                            color: _selectedIndex == 1
                                ? Colors.black
                                : Colors.grey,
                          ),
                          label: '⇑',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            color: _selectedIndex == 2
                                ? Colors.black
                                : Colors.grey,
                          ),
                          label: '⇑',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            Icons.sell_outlined,
                            color: _selectedIndex == 3
                                ? Colors.black
                                : Colors.grey,
                          ),
                          label: '⇑',
                        ),
                      ],
                    type: BottomNavigationBarType.shifting,
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
