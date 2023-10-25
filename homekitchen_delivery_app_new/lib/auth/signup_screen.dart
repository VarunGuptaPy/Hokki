import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homekitchen_delivery_app_new/auth/login_screen.dart';
import 'package:homekitchen_delivery_app_new/auth/methods/email_login_and_register.dart';
import 'package:homekitchen_delivery_app_new/auth/methods/google_signin.dart';
import 'package:homekitchen_delivery_app_new/auth/phone_auth/phone_auth_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ready to join HomeKitchen?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                    Text(
                      "Create an account now and start earning",
                      style: TextStyle(color: Color(0xff0000000)),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 6,
                ),
                Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hide = !hide;
                              });
                            },
                            icon: Icon(hide
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                          )),
                      obscureText: hide,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          registerWithEmailAndPassword(
                              context,
                              emailController.text,
                              passwordController.text,
                              nameController.text);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff2A5A52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 120,
                      child: RichText(
                        text: TextSpan(
                          text:
                              'By clicking the "Sign Up" button, you acceptthe terms of the ', // Non-Bold Text
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Privacy policy',
                                style: TextStyle(
                                    color: Color(0xff2A5A52),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "or Sign Up with",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => PhoneAuthScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.phone,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            signInWithGoogle(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 13,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (c) => LoginScreen())),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'Already have an account? Log in ', // Non-Bold Text
                          style:
                              TextStyle(color: Color(0xff7a7a7a), fontSize: 16),
                          children: [
                            TextSpan(
                                text: 'here',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff2BAF99),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
