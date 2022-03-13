import 'package:flutter/material.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mapa",
      home: Scaffold(
        appBar: AppBar(title: const Text('Mapa')),
        body: Center(
          child: SizedBox(
            child: Image.asset('./lib/assets/mapa.png'),
            height: 500,
            width: 300,
          ),
        ),
      ),
    );
  }
}
