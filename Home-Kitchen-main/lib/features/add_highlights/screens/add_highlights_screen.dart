import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_kitchen/features/add_highlights/repository/add_highlights_repository.dart';
import 'package:home_kitchen/global/utils/pick_image.dart';

class AddHighlightsScreen extends StatefulWidget {
  const AddHighlightsScreen({super.key});

  @override
  State<AddHighlightsScreen> createState() => _AddHighlightsScreenState();
}

class _AddHighlightsScreenState extends State<AddHighlightsScreen> {
  File? file;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: file == null
          ? Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2A5A52),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Create a Post +",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  file = await pickImage();
                  setState(() {
                    file;
                  });
                },
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.file(
                        file!,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(hintText: 'Image Title'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration:
                          const InputDecoration(hintText: 'Image Description'),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff2A5A52),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onPressed: () async {
                            await AddHighlightsRepository()
                                .addHighlightsToDatabase(titleController.text,
                                    descriptionController.text, file!, context);
                            setState(() {
                              file = null;
                            });
                          },
                          child: const Text(
                            'Publish',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
