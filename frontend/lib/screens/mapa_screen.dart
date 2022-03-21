import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  TextEditingController filterController = TextEditingController();

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('https://buildgreen.herokuapp.com/logout/'),
        // Send authorization headers to the backend.
        headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightGreen,
          ],
        )),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(children: const <Widget>[
              Expanded(
                child: Text(
                  'MAPA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      decoration: TextDecoration.none),
                ),
              ),
              Expanded(
                child: Image(
                  image: AssetImage("images/admin.png"),
                  height: 70,
                  width: 70,
                ),
              )
            ]),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 30, 30),
              child: TextField(
                controller: filterController,
                decoration: const InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: 'Filtrar',
                  icon: Icon(Icons.search),
                ),
              )
            ),
            Container(
              //este es el contenedor del MAPA
              height: 550,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12),
              )
            ),
            TextButton(onPressed: logOut, child: const Text('Log out'))
          ],
        ),
      ),
    ]));
  }
}
