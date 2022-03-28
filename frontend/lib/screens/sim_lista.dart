// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:buildgreen/screens/new_appliance.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../widgets/general_buttom.dart';

class ListaSimulacion extends StatefulWidget {
  const ListaSimulacion({Key? key}) : super(key: key);

  @override
  State<ListaSimulacion> createState() => _ListaSimulacion();
}

// Clase item electrodoméstico
class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
    this.id,
    this.activeMorning = false,
    this.activeAfternoon = false,
    this.activeNight = false,
  });
  String? id;
  String headerValue;
  bool isExpanded;
  bool activeMorning;
  bool activeAfternoon;
  bool activeNight;
}

//Generar electrodomésticos para la Expansion Panel List
Future<List<Item>> generateItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'https://buildgreen.herokuapp.com/appliances+?e6e2a970-6a5a-4040-b24e-581098427dc3'), //esto esta hardcodeado
    headers: <String, String>{
      HttpHeaders.authorizationHeader:
          "Token " + prefs.getString("_user_token"),
    },
  );

  final responseJson = jsonDecode(response.body);
  debugPrint(response.body);
  return List<Item>.generate(responseJson.length, (int index) {
    final appliance = responseJson[index];
    return Item(
        headerValue: appliance['appliance'].model, id: appliance['uuid']);
  });
}

List<Item> generateItems2(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: "nombreFalso 4k",
    );
  });
}

class _ListaSimulacion extends State<ListaSimulacion> {
  List<Item> _data = [];

  _ListaSimulacion() {
    generateItems().then((val) => setState(() {
          _data = val;
        }));
  }

  Future<void> newAppliance() async {
    /*
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/properties/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
      },
      body: {
        "address": "Calle Ejemplo "+ _data.length.toString(),
        "property_type": "apt"
      },
    );

    setState(() {
      int lastItemIndex = _data.length;
      Item nitem = Item(headerValue: "Calle Ejemplo "+ _data.length.toString());
      _data.insert(lastItemIndex, nitem);
    });
    */
  }

  Future <void> deleteAppliance(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse('https://buildgreen.herokuapp.com/appliances/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
      },
      body: <String, String> {
        'uuid': item.id.toString(),
      } 
    );

    debugPrint(response.body);

  }

  void simulate() {

  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: const Image(
                image: AssetImage("assets/images/propiedadadminverde.png"),
                height: 100,
                width: 100,
              ),
              title: Text(item.headerValue),
            );
          },
          body: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: const Text('Ver Electrodoméstico'),
                onTap: () {}, //que navege a la ventana de ver electrodoméstico
              ),
              ListTile(
                title: const Text('Eliminar Electrodoméstico'),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('¡ATENCIÓN!'),
                    content: const Text('¿Quieres borrar esta propiedad?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancelar'),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          //await deleteProperty(item); falta por implementar
                          setState(() {
                            _data.removeWhere(
                                (Item currentItem) => item == currentItem);
                          });
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('Selecciona el horario de uso:'),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 50,
                        width: 100,
                        child: IconButton(
                          icon: Icon(Icons.wb_sunny),
                          color: item.activeMorning ? Colors.green : Colors.black,
                          onPressed: () => setState(() {
                            item.activeMorning = !item.activeMorning;
                          }),
                        )),
                    SizedBox(
                        height: 50,
                        width: 100,
                        child: IconButton(
                            icon: Icon(Icons.brightness_4),
                            color: item.activeAfternoon
                                ? Colors.green
                                : Colors.black,
                            onPressed: () => setState(() {
                                  item.activeAfternoon = !item.activeAfternoon;
                                }))),
                    SizedBox(
                        height: 50,
                        width: 100,
                        child: IconButton(
                            icon: Icon(Icons.brightness_2),
                            color: item.activeNight ? Colors.green : Colors.black,
                            onPressed: () => setState(() {
                                  item.activeNight = !item.activeNight;
                                })))
                  ]
                )
              )
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

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
                'Simulación',
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
                'Electrodomésticos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              child: _buildPanel(),
            ),
            GeneralButton(
                title: "Añadir electrodoméstico",
                textColor: Colors.white,
                action: newAppliance),
            GeneralButton(
                title: "SIMULAR CONSUMO",
                textColor: Colors.white,
                action: simulate),
            const Padding(padding: EdgeInsets.only(bottom: 30))
          ]),
        ],
      ),
    );
  }
}
