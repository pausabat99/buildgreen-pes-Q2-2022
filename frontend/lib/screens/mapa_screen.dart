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
        margin: const EdgeInsets.only(top: 30),
        child: const Image(image: AssetImage("images/mapa.png")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(25, 40, 0, 0),
              child: const Text(
                'MAPA',
                style: TextStyle(fontSize: 20),
                //añadir la FontFamily que sea commún para todos
              )),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: TextField(
              controller: filterController,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Filtrar',
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: mapaWidget(),
          )
        ],
      ),
    );
  }
}
