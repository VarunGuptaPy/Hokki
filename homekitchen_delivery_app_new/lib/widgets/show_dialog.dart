import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  debugPrint(content);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}