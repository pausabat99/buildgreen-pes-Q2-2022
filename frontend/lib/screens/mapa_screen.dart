import 'dart:html';

import 'package:flutter/material.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: const Text('Mapa'),
          ),
          Container(
            alignment: Alignment.center,
            child: const TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Filtrar',
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 500,
            width: 300,
            color: Colors.blueAccent,
            child: const Text('Aqui va el mapa'),
          )
        ],
      ),
    );
  }
}
