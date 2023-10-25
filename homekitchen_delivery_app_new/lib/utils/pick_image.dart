import 'dart:io';

import 'package:image_picker/image_picker.dart';

pickImage() async {
  XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
  File file = File(xfile!.path);
  return file;
}
