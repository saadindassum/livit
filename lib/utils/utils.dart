import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// pick image from user gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(
    source: source,
    maxHeight: 200,
    maxWidth: 200,
  );
  if (file != null) {
    return await file.readAsBytes();
  }
  print('no image selected');
}

// display in-app error messages and other information
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
