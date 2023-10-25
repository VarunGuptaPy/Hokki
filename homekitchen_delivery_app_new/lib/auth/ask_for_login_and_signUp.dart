import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/auth_screen.dart';
import 'package:homekitchen_delivery_app_new/auth/login_screen.dart';
import 'package:homekitchen_delivery_app_new/auth/signup_screen.dart';

class AskForLoginAndSginUp extends StatefulWidget {
  const AskForLoginAndSginUp({super.key});

  @override
  State<AskForLoginAndSginUp> createState() => _AskForLoginAndSginUpState();
}

class _AskForLoginAndSginUpState extends State<AskForLoginAndSginUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset("assets/images/deliveryDriver.png"),
              Text(
                "Delivery With Home Kitchen",
                style: TextStyle(
                    fontSize: 26,
                    color: Color(0xff2F4858),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  "Make money on your terms anytime and anyhow.",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Stack(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => LoginScreen()));
                },
                child: Text(
                  "                       Log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => SignUpScreen()));
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff009E86),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
