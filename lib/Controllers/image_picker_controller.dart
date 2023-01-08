import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  File? image;
  final ImagePicker imagePicker = ImagePicker();

  Future imgFromGallery({required List list}) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      list.add(image);
      update();
    } else {
      print('No image selected.');
    }
  }

  Future imgFromCamera({required List list}) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      list.add(image);
      update();
    } else {
      print('No image selected.');
    }
  }

  void showImagePicker(
      {context, required List fromGalleryList, required List fromCameraList}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery(list: fromGalleryList);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(list: fromCameraList);
                      Navigator.of(context).pop();
                    },
                  ),

                ],
              ),
            ),
          );
        });
  }

}