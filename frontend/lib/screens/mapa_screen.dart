import 'package:flutter/material.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  TextEditingController filterController = TextEditingController();

  Widget mapaWidget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: const Image(image: AssetImage("images/mapa.png")));
  }

  Widget filtraWidget() {
    return Material(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: TextField(
          controller: filterController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Filtrar',
            border: OutlineInputBorder(),
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(50, 40, 0, 0),
            child: const Text(
              'MAPA',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            padding: const EdgeInsets.all(30),
            child: filtraWidget(),
          ),
          Container(
            child: mapaWidget(),
          )
        ]
      )
    );
  }
}
