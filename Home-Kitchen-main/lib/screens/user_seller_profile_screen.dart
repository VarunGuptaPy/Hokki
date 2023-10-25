import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/models/item.dart';
import 'package:home_kitchen/models/seller.dart';
import 'package:home_kitchen/screens/user_book_seller.dart';
import 'package:home_kitchen/screens/user_place_order_for_one_day.dart';

import '../features/profile/screen/post_detail_screen.dart';
import '../global/utils/ad_mob_service.dart';
import '../global/widgets/menuWidget.dart';
import '../models/posts.dart';

// ignore: must_be_immutable
class UserSellerProfileScreen extends StatefulWidget {
  Seller? seller;
  double? deliveryPrice;
  UserSellerProfileScreen({super.key, this.seller, this.deliveryPrice});

  @override
  State<UserSellerProfileScreen> createState() =>
      _UserSellerProfileScreenState();
}

class _UserSellerProfileScreenState extends State<UserSellerProfileScreen> {
  Map<String, dynamic> Monday = {};
  Map<String, dynamic> Tuesday = {};
  Map<String, dynamic> Wednesday = {};
  Map<String, dynamic> Thursday = {};
  Map<String, dynamic> Friday = {};
  Map<String, dynamic> Saturday = {};
  Map<String, dynamic> Sunday = {};
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  TextEditingController ChipTextController = TextEditingController();
  List<String> ChipText = [];
  List ChipTexts = [];
  List<Chip> Chips = [];
  bool hasData = false;
  Item? item;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('yo');
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.seller!.uid)
        .collection('items')
        .doc("item")
        .get()
        .then((value) {
      if (value.exists) {
        final data = value.data()!;
        item = Item.fromMap(data);
        setState(() {
          Monday = item!.Monday;
          Tuesday = item!.Tuesday;
          Wednesday = item!.Wednesday;
          Thursday = item!.Thursday;
          Friday = item!.Friday;
          Saturday = item!.Saturday;
          Sunday = item!.Sunday;
          hasData = true;
        });
      }
    });
    bannerAd = AdMobsService.createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff009E86),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => UserPlaceOrderForOneDay(
                                    item: item!,
                                    seller: widget.seller!,
                                    deliveryPrice: widget.deliveryPrice,
                                  )));
                    },
                    child: const Text(
                      'Place order for one day',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff009E86),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserBookSeller(
                                deliveryPrice: widget.deliveryPrice,
                                item: item!,
                                seller: widget.seller)));
                  },
                  child: const Text(
                    'Book Seller',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.seller!.profilePic,
                    ),
                    radius: 64,
                  )),
              Text(
                widget.seller!.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                widget.seller!.role,
                style: const TextStyle(fontSize: 25, color: Colors.grey),
              ),
              const TabBar(indicatorColor: Color(0xff009E86), tabs: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Highlights',
                    style: TextStyle(
                      color: Color(0xff009E86),
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff009E86),
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('highlights')
                          .where('uid', isEqualTo: widget.seller!.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return snapshot.hasData
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Posts posts = Posts.fromMap(
                                      snapshot.data!.docs[index].data()!
                                          as Map<String, dynamic>);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 10,
                                    ),
                                    child: GestureDetector(
                                      onTap: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    PostDetailScreen(
                                                        posts: posts)));
                                      }),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image(
                                          image:
                                              NetworkImage(posts.downloadUrl),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 1.5,
                                  crossAxisSpacing: 0,
                                ),
                              )
                            : Container();
                      },
                    ),
                    SingleChildScrollView(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 200.0),
                          child: Column(
                            children: [
                              MenuWidget(
                                day: "Monday",
                                menu: Monday,
                                isView: true,
                              ),
                              MenuWidget(
                                day: "Tuesday",
                                menu: Tuesday,
                                isView: true,
                              ),
                              MenuWidget(
                                day: "Wednesday",
                                menu: Wednesday,
                                isView: true,
                              ),
                              MenuWidget(
                                day: "Thursday",
                                menu: Thursday,
                                isView: true,
                              ),
                              MenuWidget(
                                day: "Friday",
                                menu: Friday,
                                isView: true,
                              ),
                              MenuWidget(
                                day: "Saturday",
                                menu: Saturday,
                                isView: true,
                              ),
                              MenuWidget(
                                day: "Sunday",
                                menu: Sunday,
                                isView: true,
                              ),
                              const Text(
                                'Addons',
                                style: TextStyle(fontSize: 30),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: ChipTexts.length,
                                itemBuilder: (context, index) {
                                  return Chip(
                                    label: Text(ChipTexts[index]['item']),
                                    avatar:
                                        Text('₹${ChipTexts[index]['price']}'),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
