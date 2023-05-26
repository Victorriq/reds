import 'package:flutter/material.dart';

var nombre = "Victor";
var usuario = "Victor";
var ubicacion = "España";

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListItem(
            title: 'Nombre',
            text: 'Juan Pérez',
          ),
          ListItem(
            title: 'Edad',
            text: '25 años',
          ),
          ListItem(
            title: 'Profesión',
            text: 'Ingeniero',
          ),
          ListItem(
            title: 'Nombre',
            text: 'Juan Pérez',
          ),
          ListItem(
            title: 'Edad',
            text: '25 años',
          ),
          ListItem(
            title: 'Profesión',
            text: 'Ingeniero',
          ),
          // Agrega más elementos ListItem aquí si es necesario
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String text;

  const ListItem({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white, // Texto blanco
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(
                fontSize: 16.0, color: Colors.white), // Texto blanco
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyListScreen(),
  ));
}
