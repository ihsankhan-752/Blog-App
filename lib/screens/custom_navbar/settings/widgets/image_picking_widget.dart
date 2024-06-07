import 'package:flutter/material.dart';
import 'package:get/get.dart';

imagePickingOptionDialog({Function()? onCameraClicked, Function()? onGalleryClicked}) {
  return SimpleDialog(
    title: Center(child: Text("Pick Image")),
    children: [
      ListTile(
        onTap: onCameraClicked,
        leading: Icon(Icons.camera_alt, size: 22),
        title: Text(
          "Camera",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Divider(height: 0.1),
      ListTile(
        onTap: onGalleryClicked,
        leading: Icon(Icons.photo, size: 22),
        title: Text(
          "Gallery",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Divider(height: 0.1),
      ListTile(
        onTap: () {
          Get.back();
        },
        leading: Icon(Icons.close, size: 22),
        title: Text(
          "Cancel",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
