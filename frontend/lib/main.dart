
import 'package:buildgreen/screens/appliance_compare_screen.dart';
import 'package:buildgreen/screens/forms/new_appliance.dart';
import 'package:buildgreen/screens/forms/signup_screen.dart';
import 'package:buildgreen/screens/lista_electrodomesticos.dart';
import 'package:buildgreen/screens/forms/login_screen.dart';
import 'package:buildgreen/screens/main_screen.dart';
import 'package:buildgreen/screens/resultados_simulacion.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:buildgreen/screens/sim_lista.dart';

import 'package:buildgreen/screens/welcome_screen.dart';

import 'package:flutter/material.dart';

import 'screens/forms/new_appliance.dart';
import 'screens/forms/signup_screen.dart';


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
      LogInScreen.route           :(context) => const LogInScreen(),
      SignUpScreen.route          :(context) => const SignUpScreen(),
      MainScreen.route            :(context) => const MainScreen(),
      ListaSimulacion.route       :(context) => const ListaSimulacion(),
      ElectrodomesticoList.route  :(context) => const ElectrodomesticoList(),
      NewAppliance.route          :(context) => const NewAppliance(),
      ResultadosSimulacion.route  :(context) => const ResultadosSimulacion(), 
      WelcomeScreen.route         :(context) => const WelcomeScreen(),
      },
      theme: ThemeData(
        fontFamily: 'Arial',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.black),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
          headline2: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        primarySwatch: Colors.green,
      ),
      home: const WelcomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
