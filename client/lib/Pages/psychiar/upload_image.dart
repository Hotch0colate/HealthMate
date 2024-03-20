import 'dart:io';

import 'package:client/component/buttons.dart';
import 'package:client/theme/color.dart';
import 'package:client/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _getImage(ImageSource.gallery); // Change to ImageSource.camera for camera
      },
      child: Container(
        height: 200,
        width: 400,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12),          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_image != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(
                      _image!,
                      width: 250.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      onPressed: _clearImage,
                      icon: Icon(Icons.delete),
                      color: ColorTheme.errorAction,
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Icon(Icons.cloud_upload,color: ColorTheme.secondaryColor,), // Add upload icon
                    Text(
                      'อัพโหลดรูปภาพ',
                      style: FontTheme.body2,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
