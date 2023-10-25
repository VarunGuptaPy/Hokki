import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_kitchen/features/auth/repository/auth_repository.dart';
import 'package:home_kitchen/features/auth/screen/phone_auth/phone_auth_screen.dart';

class NameTakingScreen extends ConsumerStatefulWidget {
  bool? isPhone;
  String? phone;
  NameTakingScreen({super.key, this.isPhone, this.phone});

  @override
  ConsumerState<NameTakingScreen> createState() => _NameTakingScreenState();
}

class _NameTakingScreenState extends ConsumerState<NameTakingScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Design.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.67,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              width: MediaQuery.of(context).size.width,
              height: 2,
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Color(0xffE8E8E8)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff009E86), width: 2),
                    color: const Color(0xff00B965),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    subtitle: TextField(
                      controller: nameController,
                      cursorHeight: 20,
                    ),
                    title: const Text(
                      "Enter Your Name",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text != "") {
                  if (widget.isPhone!) {
                    ref.watch(authRepositoryProvider).uploadUserDataToFirebase(
                        context: context,
                        name: nameController.text,
                        role: 'user',
                        phoneNumber: widget.phone!);
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => PhoneAuthScreen(
                                isAuth: false,
                                name: nameController.text,
                              )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Give Name")));
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5, backgroundColor: const Color(0xff00B965)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Next",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
