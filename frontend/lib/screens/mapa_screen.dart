import 'package:flutter/material.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          )
        ],
      ),
    );
  }
}
