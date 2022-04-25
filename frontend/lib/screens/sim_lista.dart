// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'dart:convert';
//import 'dart:ffi';

import 'package:buildgreen/screens/appliance_compare_screen.dart';
import 'package:buildgreen/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../widgets/general_buttom.dart';

class ListaSimulacion extends StatefulWidget {

  static const route = "/sim";
  
  const ListaSimulacion({Key? key}) : super(key: key);

  @override
  State<ListaSimulacion> createState() => _ListaSimulacion();
}

// Clase item electrodoméstico
class Item {
  Item({
    required this.headerValue,
    required this.model,
    required this.brand,
    required this.price,
    required this.cons,
    this.isExpanded = false,
    required this.id,
    this.activeMorning = false,
    this.activeAfternoon = false,
    this.activeNight = false,
  });

  String id;

  String headerValue;
  String model;
  String brand;
  String price;
  String cons;
  bool isExpanded;
  bool activeMorning;
  bool activeAfternoon;
  bool activeNight;
}

//Generar electrodomésticos para la Expansion Panel List
Future<List<Item>> generateItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String property = prefs.getString('_actual_property');
  final response = await http.get(
    Uri.parse(
        'https://buildgreen.herokuapp.com/appliances?property=' + property),
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
        id: appliance['uuid'],
        activeAfternoon: appliance['noon'],
        activeMorning: appliance['morning'],
        activeNight: appliance['night'],
        brand: appliance['appliance']['brand'],
        model: appliance['appliance']['model'],
        price: appliance['appliance']['price'].toString(),
        cons: appliance['appliance']['cons'].toString());
  });
}

class _ListaSimulacion extends State<ListaSimulacion> {
  List<Item> _data = [];
  var value = "";

  _ListaSimulacion() {
    generateItems().then((val) => setState(() {
          _data = val;
        }));
  }

  Future<void> newAppliance() async {
    await Navigator.of(context).pushNamed('/all_appliances');
    _data = await generateItems();
    setState(() {});
  }

  Future<void> deleteAppliance(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
        Uri.parse('https://buildgreen.herokuapp.com/appliances/'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              "Token " + prefs.getString("_user_token"),
        },
        body: <String, String>{
          'uuid': item.id.toString(),
        });
  }

  Future<void> updateSchedule(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.patch(
        Uri.parse('https://buildgreen.herokuapp.com/appliances/' +
            item.id.toString() +
            '/'),
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
  }

  void simulate() {
    Navigator.pushNamed(context, '/sim_result');
  }
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        for (var t_item in _data ) {
          if(_data[index] != t_item) t_item.isExpanded = false; 
        }
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
          body: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Column(
                  children: [
                    Text('Marca: ' + item.brand, textAlign: TextAlign.left),
                    Text('Modelo: ' + item.model, textAlign: TextAlign.left),
                    Text('Precio: ' + item.price, textAlign: TextAlign.left),
                    Text('Consumo: ' + item.cons, textAlign: TextAlign.left),
                  ],
                ),
              ),
              ListTile(
                  title: Text('Selecciona el horario de uso:'),
                  trailing: SizedBox(
                    width: 150,
                    child: Row(children: [
                      IconButton(
                          icon: Icon(Icons.wb_sunny),
                          color: item.activeMorning ? Colors.green : Colors.black,
                          onPressed: () async {
                            setState(() {
                              item.activeMorning = !item.activeMorning;
                            });
                            await updateSchedule(item);
                          }),
                      IconButton(
                          icon: Icon(Icons.brightness_4),
                          color:
                              item.activeAfternoon ? Colors.green : Colors.black,
                          onPressed: () async {
                            setState(() {
                              item.activeAfternoon = !item.activeAfternoon;
                            });
                            await updateSchedule(item);
                          }),
                      IconButton(
                          icon: Icon(Icons.brightness_2),
                          color: item.activeNight ? Colors.green : Colors.black,
                          onPressed: () async {
                            setState(() {
                              item.activeNight = !item.activeNight;
                            });
                            await updateSchedule(item);
                          }),
                    ]),
                  )),
              ListTile(
                title: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      child: Text('Borrar'),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('¡ATENCIÓN!'),
                          content: const Text(
                              '¿Quieres borrar este electrodoméstico de tu propiedad?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancelar'),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await deleteAppliance(item);
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
                    Expanded(child: Container()),
                    ElevatedButton.icon(
                      icon: Icon(Icons.settings_suggest_rounded),
                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      label: Text('Cambiar'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompareApplianceScreen(startObject: item),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
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
      body: Container(
        child: Column(
          children: [
            /// BACK BUTTON
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                top: 30,
              ),
              child: CustomBackButton(
                buttonColor: Colors.black,
              ),
            ),

            /// TITLE
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                top: 10,
              ),
              child: Text("Mi prioridad"),
            ),

            /// Subtitle
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                bottom: 10,
              ),
              child: const Text(
                'Electrodomésticos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            // get the screen height

            Container(
              height: MediaQuery.of(context).size.height - 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.green, Colors.lightGreen]),
                boxShadow: [
                  BoxShadow(blurRadius: 3, blurStyle: BlurStyle.normal),
                ],
              ),
              child: ListView(

                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    _buildPanel(),
                    const Padding(padding: EdgeInsets.all(5)),
                    GeneralButton(
                      title: "Añadir electrodoméstico",
                      textColor: Colors.white,
                      action: newAppliance,
                    ),
                    Padding(padding: EdgeInsets.all(15))
                  ],
              ),
            ),
            Expanded(child: Text("")),
            Align(
                alignment: Alignment.bottomCenter,
                child: GeneralButton(
                    title: "SIMULAR CONSUMO",
                    textColor: Colors.white,
                    action: simulate),
              ),
            Expanded(child: Text("")),
          ],
        ),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.lightGreen,
          ],
        )),
      ),
    );
  }
}
