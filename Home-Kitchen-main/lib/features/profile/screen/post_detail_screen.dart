import 'package:flutter/material.dart';
import 'package:home_kitchen/models/posts.dart';

class PostDetailScreen extends StatefulWidget {
  Posts posts;
  PostDetailScreen({super.key, required this.posts});

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
