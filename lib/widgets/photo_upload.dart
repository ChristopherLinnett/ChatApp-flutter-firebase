import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUpload extends StatefulWidget {
  const PhotoUpload({Key? key, required this.imageUpdater}) : super(key: key);
  final Function imageUpdater;

  @override
  State<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File? _pickedImage;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 250);
    if (image == null) {
      return;
    }
    var pickedImage = File(image.path);

    setState(() {
      _pickedImage = pickedImage;
    });
    widget.imageUpdater(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage!),
        ),
        TextButton.icon(
            icon: Icon(
              Icons.photo_camera,
              size: 24,
            ),
            label: Text(
              "Add Photo",
            ),
            onPressed: _pickImage),
      ],
    );
  }
}
