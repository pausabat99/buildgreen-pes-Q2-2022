import 'package:buildgreen/screens/login_screen.dart';
import 'package:buildgreen/screens/main_screen.dart';
import 'package:buildgreen/screens/signup_screen.dart';
import 'package:buildgreen/screens/area_personal_cliente.dart';

import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => const LogInScreen(),
        '/register': (context) => const SignUpScreen(),
        '/index': (context) => const MainScreen(),
      },
      theme: ThemeData(
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.black),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
        ),
        primarySwatch: Colors.green,
      ),
      home: const AreaPersonalCliente(),
    );
  }
}
