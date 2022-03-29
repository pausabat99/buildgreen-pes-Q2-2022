
import 'package:buildgreen/screens/login_screen.dart';
import 'package:buildgreen/screens/main_screen.dart';
import 'package:buildgreen/screens/signup_screen.dart';
import 'package:buildgreen/screens/sim_lista.dart';
import 'package:buildgreen/screens/welcome_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';


void main()  {
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
      '/sim':(context) => const ListaSimulacion(),
      },
      theme: ThemeData(
        fontFamily: 'Arial',
        
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.black),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
        ),

        primarySwatch: Colors.green,
      ),
      home: const WelcomeScreen()
    );
  }
}
