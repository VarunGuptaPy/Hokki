import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_kitchen/features/auth/controller/auth_controlller.dart';
import 'package:home_kitchen/features/auth/screen/phone_auth/phone_auth_screen.dart';
import 'package:home_kitchen/global/widgets/show_dialog.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  void signInWithGoogle() async {
    AuthController authController = ref.watch(authcontrollerProvider);
    authController.signInWithGoogle(context);
  }

  bool isSignIn = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showCircle = false;
  bool obscureText = true;
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
                                                          "       Sign up",
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
                                                      "Log in         ",
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
                                                          "Sign up",
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
                                                decoration: InputDecoration(
                                                  hintText: "Shanti gupta",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  ),
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
                                      decoration: InputDecoration(
                                        hintText: "abc@gmail.com",
                                        hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
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
                                    ListTile(
                                      title: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Enter password Here",
                                          hintStyle: TextStyle(
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        cursorHeight: 20,
                                        controller: passwordController,
                                        obscureText: obscureText,
                                      ),
                                      trailing: IconButton(
                                        icon: obscureText
                                            ? Icon(Icons.visibility)
                                            : Icon(Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                      ),
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
                                            onPressed: () async {
                                              if (emailController.text
                                                      .trim()
                                                      .isNotEmpty &&
                                                  passwordController.text
                                                      .trim()
                                                      .isNotEmpty) {
                                                if (isSignIn) {
                                                  if (nameController.text
                                                      .trim()
                                                      .trim()
                                                      .isNotEmpty) {
                                                    setState(
                                                      () {
                                                        showCircle = true;
                                                      },
                                                    );

                                                    await ref
                                                        .watch(
                                                            authcontrollerProvider)
                                                        .RegisterWithEmailAndPassword(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            name: nameController
                                                                .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            context: context,
                                                            showCircle:
                                                                showCircle);
                                                  }
                                                } else {
                                                  setState(
                                                    () {
                                                      showCircle = true;
                                                    },
                                                  );
                                                  await ref
                                                      .watch(
                                                          authcontrollerProvider)
                                                      .logInWithEmailAndPassword(
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                          context: context,
                                                          showCircle:
                                                              showCircle);
                                                  setState(
                                                    () {
                                                      showCircle = false;
                                                    },
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Please fill all fields"),
                                                  ),
                                                );
                                                setState(() {
                                                  showCircle = false;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: isSignIn
                                                  ? const Text(
                                                      "Sign up",
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
                                                  child:
                                                      Text("Forget Password?"))
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
                                      signInWithGoogle();
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
                                              PhoneAuthScreen(
                                                isAuth: true,
                                                name: "",
                                              )),
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
