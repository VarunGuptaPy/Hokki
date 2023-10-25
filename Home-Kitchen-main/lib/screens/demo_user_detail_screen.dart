import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_kitchen/global/utils/maputils.dart';
import 'package:home_kitchen/models/demo.dart';
// ignore_for_file: must_be_immutable

class DemoUserDetailScreen extends StatefulWidget {
  Demo? demo;
  DemoUserDetailScreen({super.key, this.demo});

  @override
  State<DemoUserDetailScreen> createState() => _DemoUserDetailScreenState();
}

class _DemoUserDetailScreenState extends State<DemoUserDetailScreen> {
  List positions = [];
  Position? position;
  List<Placemark>? placemarks;
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

  double lan = 0;
  double lat = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      positions = await getCurrentLocation();
      setState(() {
        lat = positions[1];
        lan = positions[2];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                  radius: 64,
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  widget.demo!.userName,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Text(
                'Date',
                style: TextStyle(fontSize: 20),
              ),
              title: Text(
                widget.demo!.date,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Text(
                'Time',
                style: TextStyle(fontSize: 20),
              ),
              title: Text(
                widget.demo!.time,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2A5A52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {
                  MapUtils.ShowMapsFromOneLocationToLocation(
                      lat, lan, widget.demo!.userLat, widget.demo!.userLng);
                },
                child: const Text(
                  'Navigate to User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
