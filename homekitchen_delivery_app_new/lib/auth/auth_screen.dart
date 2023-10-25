import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homekitchen_delivery_app_new/auth/methods/email_login_and_register.dart';
import 'package:homekitchen_delivery_app_new/auth/phone_auth/phone_auth_screen.dart';

import '../widgets/show_dialog.dart';
import 'methods/google_signin.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:home_kitchen/features/auth/controller/auth_controlller.dart';
// import 'package:home_kitchen/features/auth/screen/phone_auth/phone_auth_screen.dart';
// import 'package:home_kitchen/global/widgets/show_dialog.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showCircle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      // The image widget aligned at the top
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(100)),
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 2,
                              sigmaY: 2,
                            ),
                            child: Image.asset(
                              'assets/images/thali2.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 290, // Set the constant height here
                            ),
                          ),
                        ),
                      ),

                      // The content container positioned at the bottom
                      Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(5, 5),
                                      blurRadius: 5, // Softness of the shadow
                                      spreadRadius: 1),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Stack(
                                        children: isSignIn == false
                                            ? [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 55.0),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          shape:
                                                              const StadiumBorder(),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xffE8E8E8)),
                                                      onPressed: () => {
                                                            setState(() {
                                                              isSignIn = true;
                                                            })
                                                          },
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "    Sign In",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff00B965),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          const StadiumBorder(),
                                                      backgroundColor:
                                                          const Color(
                                                              0xff00B965)),
                                                  onPressed: () => {},
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Log in",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]
                                            : [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          const StadiumBorder(),
                                                      backgroundColor:
                                                          const Color(
                                                              0xffE8E8E8)),
                                                  onPressed: () => {
                                                    setState(() {
                                                      isSignIn = false;
                                                    })
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Log in      ",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff00B965),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 75.0),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          shape:
                                                              const StadiumBorder(),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xff00B965)),
                                                      onPressed: () => {},
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Sign In",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    isSignIn
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Name",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              TextField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Shanti gupta",
                                                ),
                                                cursorHeight: 20,
                                                controller: nameController,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextField(
                                      cursorHeight: 20,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          hintText: "abc@gmail.com"),
                                      controller: emailController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter password Here"),
                                      cursorHeight: 20,
                                      controller: passwordController,
                                      obscureText: true,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                backgroundColor:
                                                    const Color(0xff00B965)),
                                            onPressed: () => {
                                              if (isSignIn)
                                                {
                                                  if (emailController.text !=
                                                          "" &&
                                                      passwordController.text !=
                                                          "" &&
                                                      nameController.text != "")
                                                    {
                                                      registerWithEmailAndPassword(
                                                          context,
                                                          emailController.text,
                                                          passwordController
                                                              .text,
                                                          nameController.text)
                                                    }
                                                  else
                                                    {
                                                      showSnackBar(context,
                                                          "Please fill all fields")
                                                    }
                                                }
                                              else
                                                {
                                                  if (emailController.text !=
                                                          "" &&
                                                      passwordController.text !=
                                                          "")
                                                    {
                                                      logInWithEmailAndPassword(
                                                          context,
                                                          emailController.text,
                                                          passwordController
                                                              .text)
                                                    }
                                                  else
                                                    {
                                                      showSnackBar(context,
                                                          "Please fill all fields.")
                                                    }
                                                }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: isSignIn
                                                  ? const Text(
                                                      "Sign in",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "Log in",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          isSignIn == false
                                              ? TextButton(
                                                  onPressed: () async {
                                                    if (emailController.text ==
                                                        "") {
                                                      showSnackBar(context,
                                                          "Please provide your email");
                                                    } else {
                                                      try {
                                                        showSnackBar(context,
                                                            "Password Reset Email Sent");
                                                        await FirebaseAuth
                                                            .instance
                                                            .sendPasswordResetEmail(
                                                                email:
                                                                    emailController
                                                                        .text
                                                                        .trim());
                                                      } on FirebaseAuthException catch (e) {
                                                        showSnackBar(context,
                                                            e.message!);
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                      "Forget Password?"))
                                              : Container(),
                                          showCircle
                                              ? CircularProgressIndicator()
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Center(
                              child: Text(
                            "Or",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          )),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      signInWithGoogle(context);
                                    },
                                    child: const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                          "assets/images/google.png"),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "Google",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              PhoneAuthScreen()),
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage("assets/images/phone.png"),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "Phone",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }
}
