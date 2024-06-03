import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  Future<void> pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null && pickedFile != _selectedImage) {
      _selectedImage = File(pickedFile.path);

      notifyListeners();
    }
  }

  clearUploadImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
