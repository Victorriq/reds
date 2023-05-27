import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4'
  ];
  List<IconData> icons = [
    Icons.image,
    Icons.video_library,
    Icons.attach_money,
    Icons.poll
  ];

  bool showImage = false;
  XFile? selectedImage;

  Future<void> requestPermissionsAndOpenGallery() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    if (statuses[Permission.camera]!.isGranted &&
        statuses[Permission.storage]!.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          showImage = true;
          selectedImage = image;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permisos requeridos'),
          content: const Text(
              'Debes aceptar los permisos de cámara y galería para acceder a la galería.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void clearSelectedImage() {
    setState(() {
      showImage = false;
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(top: 16),
        child: showImage
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.red, // Color rojo
                        ),
                        onPressed: clearSelectedImage,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: selectedImage != null
                          ? Image.file(
                              File(selectedImage!.path),
                              fit: BoxFit.contain,
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.grey[800],
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      title: Text(
                        items[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        if (index == 0) {
                          requestPermissionsAndOpenGallery();
                        } else {
                          print('Elemento clicado: ${items[index]}');
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
