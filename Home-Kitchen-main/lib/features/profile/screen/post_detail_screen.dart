import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_kitchen/models/posts.dart';
import 'package:home_kitchen/screens/sellerHomeScreen.dart';

class PostDetailScreen extends StatefulWidget {
  Posts posts;
  bool? isSeller;
  PostDetailScreen({super.key, required this.posts, this.isSeller});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Detail Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: widget.isSeller!
            ? [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("highlights")
                              .doc(widget.posts.id)
                              .delete();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SellerHomeScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Delete Post'),
                          ],
                        ),
                      ),
                    ),
                  ],
                  icon: Icon(Icons.more_vert),
                ),
              ]
            : [],
      ),
      body: Column(children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  widget.posts.downloadUrl,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Text(
                  widget.posts.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                title: Text(
                  widget.posts.description,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
