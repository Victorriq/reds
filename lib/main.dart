import 'package:flutter/material.dart';
import 'package:reds/root.dart';
import 'screens/login.dart';
import 'package:reds/screens/index.dart';

bool logeado = false;

void main() async {
  final routes = {
    '/': (context) => const Root(),
    '/home': (context) => const HomePage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage()
  };

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: logeado ? '/' : '/login',
      routes: routes,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
      },
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}
