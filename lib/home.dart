import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? file;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final temproraryImage = File(image.path);

      setState(() {
        file = temproraryImage;
      });
    } on PlatformException catch (e) {
      debugPrint("failed to open image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[200],
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 150,
          ),
          file != null
              ? Image.file(
                  file!,
                  height: 260,
                  width: 260,
                  // fit: BoxFit.cover,
                )
              : const FlutterLogo(
                  size: 160,
                ),
          const Center(
            child: Text(
              "Image picker",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(150, 50)),
              ),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              child: Row(
                children: const [
                  Icon(Icons.image),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Pic From Gallery")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(150, 50)),
              ),
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Capture Image")
                ],
              ),
            ),
          ),
        ]));
  }

  // call() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //   final temporaryImage = File(image.path);

  //   setState(() {
  //     file = temporaryImage;
  //   });
  // }
}