// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ResultadosSimulacion extends StatefulWidget {
  const ResultadosSimulacion({Key? key}) : super(key: key);

  @override
  State<ResultadosSimulacion> createState() => _ResultadosSimulacion();
}

class _ResultadosSimulacion extends State<ResultadosSimulacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          Column(children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                top: 10,
              ),
              child: const Text(
                'Simulacion',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                bottom: 50,
              ),
              child: const Text(
                'Resultados totales',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              child: SizedBox(
                width: 150,
                child: Row(children: [
                  IconButton(
                    icon: Icon(Icons.wb_sunny),
                    color: Colors.green,
                    onPressed: () => setState(() {}),
                  ),
                  IconButton(
                      icon: Icon(Icons.brightness_4),
                      color: Colors.green,
                      onPressed: () => setState(() {})),
                  IconButton(
                      icon: Icon(Icons.brightness_2),
                      color: Colors.green,
                      onPressed: () => setState(() {}))
                ]),
              ),
            ),
            Container(
                //Aqui la simulacion
                ),
          ]),
        ],
      ),
    );
  }
}
