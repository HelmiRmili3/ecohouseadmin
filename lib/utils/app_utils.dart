import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AppUtils {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
Future<File?> pickImage() async {
  File? image;
  final picker = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowCompression: true,
  );

  if (picker != null && picker.files.isNotEmpty) {
    image = File(picker.files.first.path!);
  }

  return image;
}
