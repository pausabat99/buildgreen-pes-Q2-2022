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
    required this.id,
    this.activeMorning = false,
    this.activeAfternoon = false,
    this.activeNight = false,
  });

  String id;

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
        'https://buildgreen.herokuapp.com/appliances?property=b064d823-b578-4cb4-8a6a-9bbc60f6e5b5'), //esto esta hardcodeado
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
        headerValue: appliance['appliance']['brand'] +
            ' ' +
            appliance['appliance']['model'],
        id: appliance['uuid']);
  });
}

class _ListaSimulacion extends State<ListaSimulacion> {
  List<Item> _data = [];

  _ListaSimulacion() {
    generateItems().then((val) => setState(() {
          _data = val;
        }));
  }

  Future<void> newAppliance() async {}

  Future<void> deleteAppliance(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
        Uri.parse('https://buildgreen.herokuapp.com/appliances/'),
        headers: <String, String>{
          //a8275004db03b2bf6409aebcb3c7478ec106ce0e84c89546ed20bd953ba73c75 toke hardcodeado
          //HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
          HttpHeaders.authorizationHeader:
              "Token " + prefs.getString("_user_token"),
        },
        body: <String, String>{
          'uuid': item.id.toString(),
        });

    debugPrint(response.body);
  }

  Future<void> updateSchedule(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.patch(
        Uri.parse('https://buildgreen.herokuapp.com/appliances/' +
            item.id.toString()),
        headers: <String, String>{
          //a8275004db03b2bf6409aebcb3c7478ec106ce0e84c89546ed20bd953ba73c75 token pau
          HttpHeaders.authorizationHeader:
              "Token " + prefs.getString("_user_token"),
        },
        body: <String, String>{
          'morning': item.activeMorning.toString(),
          'noon': item.activeAfternoon.toString(),
          'night': item.activeNight.toString(),
        });

    debugPrint(response.body);
  }

  void simulate() {}

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
                image: AssetImage("assets/images/electrodomestico.png"),
                height: 100,
                width: 100,
              ),
              title: Text(item.headerValue),
            );
          },
          body: ListView(shrinkWrap: true, children: [
            ListTile(
                title: Text('Selecciona el horario de uso:'),
                trailing: SizedBox(
                  width: 150,
                  child: Row(children: [
                    IconButton(
                        icon: Icon(Icons.wb_sunny),
                        color: item.activeMorning ? Colors.green : Colors.black,
                        onPressed: () async {
                          await updateSchedule(item);
                          setState(() {
                            item.activeMorning = !item.activeMorning;
                          });
                        }),
                    IconButton(
                        icon: Icon(Icons.brightness_4),
                        color:
                            item.activeAfternoon ? Colors.green : Colors.black,
                        onPressed: () async {
                          await updateSchedule(item);
                          setState(() {
                            item.activeAfternoon = !item.activeAfternoon;
                          });
                        }),
                    IconButton(
                        icon: Icon(Icons.brightness_2),
                        color: item.activeNight ? Colors.green : Colors.black,
                        onPressed: () async {
                          await updateSchedule(item);
                          setState(() {
                            item.activeNight = !item.activeNight;
                          });
                        })
                  ]),
                )),
            ListTile(
              title: const Text('Borrar'),
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
            )
          ]),
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
                'SIMULACIÓN',
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
