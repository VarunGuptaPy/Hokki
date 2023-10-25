// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_kitchen/models/bookSeller.dart';

import '../global/utils/maputils.dart';

class BookUserDetail extends StatefulWidget {
  BookSeller? bookSeller;
  BookUserDetail({super.key, required this.bookSeller});

  @override
  State<BookUserDetail> createState() => _BookUserDetailState();
}

class _BookUserDetailState extends State<BookUserDetail> {
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
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.bookSeller!.userName,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ListTile(
                leading: Text(
                  'Date begin',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                title: Text(
                  widget.bookSeller!.startDate,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: ListTile(
                leading: Text(
                  'Date End',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                title: Text(
                  widget.bookSeller!.endDate,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Text(
              'Days Food Wanted',
              style: TextStyle(fontSize: 30),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.bookSeller!.daysWanted.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Container(
                    color: Color(0xff009E86),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      widget.bookSeller!.daysWanted[index],
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
            Text(
              'Days Not Wanted',
              style: TextStyle(fontSize: 30),
            ),
            widget.bookSeller!.daysNotWanted.length != 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.bookSeller!.daysNotWanted.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Container(
                          color: Color(0xff009E86),
                          padding: EdgeInsets.all(15),
                          child: Text(
                            widget.bookSeller!.daysWanted[index],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                : Text(
                    'none',
                    style: TextStyle(fontSize: 20),
                  )
          ],
        ),
      ),
    );
  }
}
