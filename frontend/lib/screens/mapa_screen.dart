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
    return Stack(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(25, 40, 0, 0),
            child: const Text(
              'MAPA',
              style: TextStyle(color: Colors.black, 
                              fontSize: 40,
                              decoration: TextDecoration.none),
              //añadir la FontFamily que sea commún para todos
            )),
        Container(
          margin: const EdgeInsets.fromLTRB(25, 120, 0, 0),
          height: 30,
          width: 360,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.lightGreen),
          child: const Text(
            'Filtrar',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,
                            fontSize: 20,
                            decoration: TextDecoration.none),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: mapaWidget(),
        )
      ],
    );
  }
}
