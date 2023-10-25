import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home_kitchen/features/auth/repository/auth_repository.dart';
import 'package:home_kitchen/global/utils/pick_image.dart';

class SellerInformaitionScreen extends ConsumerStatefulWidget {
  String? phone;
  SellerInformaitionScreen({super.key, this.phone});

  @override
  ConsumerState<SellerInformaitionScreen> createState() =>
      SellerInformaitionScreenState();
}

class SellerInformaitionScreenState
    extends ConsumerState<SellerInformaitionScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  List positions = [];
  Position? position;
  List<Placemark>? placemarks;
  String completeAddress = "";
  getCurrentLocation() async {
    Placemark? placemark;
    await Geolocator.requestPermission().whenComplete(() async {
      Position newPos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      position = newPos;
      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMark = placemarks![0];
      completeAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';
      locationController.text = completeAddress;
      placemark = pMark;
    });
    return [placemark, position!.latitude, position!.longitude];
  }

  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: file == null
                        ? GestureDetector(
                            onTap: () async {
                              file = await pickImage();
                              setState(() {
                                file;
                              });
                            },
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                            ))
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: FileImage(file!),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5,
                                offset: Offset(5, 5)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Provider Name",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: nameController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        positions = await getCurrentLocation();
                                      },
                                      icon: Icon(Icons.my_location))
                                ],
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  enabled: false,
                                ),
                                controller: locationController,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 30,
                                      backgroundColor: Color(0xff00B965),
                                    ),
                                    onPressed: () {
                                      if (locationController.text.isNotEmpty &&
                                          nameController.text.isNotEmpty) {
                                        ref
                                            .watch(authRepositoryProvider)
                                            .uploadSellerDataToFirebase(
                                                context: context,
                                                lat: positions[1],
                                                lng: positions[2],
                                                role: "seller",
                                                phoneNumber: widget.phone!,
                                                name: nameController.text,
                                                address:
                                                    locationController.text,
                                                placemark: positions[0],
                                                profilePic: file);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 30),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/armFold.png",
                    height: 150,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
