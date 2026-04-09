import 'dart:io';

import 'package:dotsoft/helpers/points_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum PhotoType {
  lights,
  recycle,
  transport,
  other,
}

class MyPhotosPage extends StatefulWidget {
  const MyPhotosPage({super.key});

  @override
  State<MyPhotosPage> createState() => _MyPhotosPageState();
}

class _MyPhotosPageState extends State<MyPhotosPage> {
  PhotoType selectedType = PhotoType.lights;

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9AB17A),
        title: Text('Upload your eco-action'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 16),
              DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: PhotoType.lights,
                    child: Text('Lights off'),
                  ),
                  DropdownMenuItem(
                    value: PhotoType.recycle,
                    child: Text('Recycle'),
                  ),
                  DropdownMenuItem(
                    value: PhotoType.transport,
                    child: Text('Transport'),
                  ),
                  DropdownMenuItem(
                    value: PhotoType.other,
                    child: Text('Other'),
                  ),
                ],
                value: selectedType,
                onChanged: (type) {
                  setState(() {
                    selectedType = type!;
                  });
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  await pickImage(fromCamera: true).then((image) {
                    selectedImage = image;
                    setState(() {});
                  });
                },
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: (selectedImage == null)
                    ? null
                    : () {
                        PointsHelper.instance.photoPoints = 15;
                        PointsHelper.instance.isPhotoPlayed = true;
                        openAlert();
                      },
                child: Text('Submit'),
              ),
              const SizedBox(height: 16),
              if (selectedImage != null)
                SizedBox(
                  width: MediaQuery.of(context).size.width - 36,
                  child: Image.file(selectedImage!),
                ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> pickImage({required bool fromCamera}) async {
    final ImagePicker picker = ImagePicker();

    try {
      // Pick an image from camera or gallery
      final XFile? image = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 800, // optional: resize for performance
        maxHeight: 800,
        imageQuality: 80, // optional: compress image
      );

      if (image == null) return null; // user canceled
      return File(image.path); // return a File object
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  void openAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'You got 15 points!',
          ),
          content: Text(
            selectedType.name,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
