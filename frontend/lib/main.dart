import 'package:buildgreen/screens/new_appliance.dart';
import 'package:flutter/material.dart';

import 'classes/user_preferences.dart';
import 'screens/welcome_screen.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();

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
          headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
        ),

        primarySwatch: Colors.green,
      ),
      home: const NewAppliance(),
    );
  }
}
