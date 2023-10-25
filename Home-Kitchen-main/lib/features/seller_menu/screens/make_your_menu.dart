import 'package:flutter/material.dart';
import 'package:home_kitchen/global/widgets/circlePainter.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';

class MakeYourMenu extends StatefulWidget {
  const MakeYourMenu({super.key});

  @override
  State<MakeYourMenu> createState() => _MakeYourMenuState();
}

class _MakeYourMenuState extends State<MakeYourMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                bottom: -80,
                left: MediaQuery.of(context).size.width * 0.33,
                child: CustomPaint(
                  painter: CirclePainter(),
                  child: Container(
                    height: 240,
                    width: 260,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Make Your Menu",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/chef.png",
                  height: 470,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => SellerHomeScreen()));
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                        child: Text(
                          "Start",
                          style: TextStyle(fontSize: 40),
                        ),
                      )),
                ),
              ],
            ),
            Positioned(
              child: Image.asset("assets/images/circle.png"),
              top: -70,
              right: -110,
            ),
          ],
        ),
      ),
    );
  }
}
