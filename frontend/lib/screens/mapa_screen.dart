// ignore_for_file: import_of_legacy_library_into_null_safe


import 'package:flutter/material.dart';
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
          ],
        ),
      ),
    );
  }
}
