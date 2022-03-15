import 'package:buildgreen/screens/login_screen.dart';
import 'package:buildgreen/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/mapa_screen.dart';
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
      theme: ThemeData(
        fontFamily: 'Arial',
        
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          bodyText1: TextStyle(fontSize: 20.0, color: Colors.white),
        ),

        primarySwatch: Colors.green,
      ),
      home: const LogInScreen(),
    );
  }
}
