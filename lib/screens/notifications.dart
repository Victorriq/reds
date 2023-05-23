import 'package:flutter/material.dart';


class NotisPage extends StatefulWidget {
  const NotisPage({super.key});

  @override
  State<NotisPage> createState() => _NotisPageState();
}

class _NotisPageState extends State<NotisPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notis'),
      ),
    );
  }
}