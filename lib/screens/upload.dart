import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload'),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.grey[800],
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  print('Elemento clicado: ${items[index]}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
