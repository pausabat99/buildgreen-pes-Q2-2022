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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Mapa',
                style: TextStyle(fontSize: 20),
            )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: filterController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Filtrar',
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              height: 500,
              width: 300,
              color: Colors.blueAccent,
              child: const Image(image: AssetImage("images/foto_mapa.png"))
            )
          ],
        ),
      ),
    );
  }
}
