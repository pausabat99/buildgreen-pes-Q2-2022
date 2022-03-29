
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ElectrodomesticoList extends StatefulWidget {
  const ElectrodomesticoList({Key? key}) : super(key: key);

  @override
  State<ElectrodomesticoList> createState() => _ElectrodomesticoList();
}

//Classe Item Propiedad
class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
    required this.applianceType,
    required this.model,
    required this.brand,
    required this.cons,
    required this.price,
  });

  String headerValue;
  bool isExpanded;
  String applianceType;
  String model;
  String brand;
  String cons;
  String price;
}

//Generar propiedades para la Expansion Panel List
Future<List<Item>> generateItems() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(
      Uri.parse('https://buildgreen.herokuapp.com/appliances_all/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
      },
  );

  final responseJson = jsonDecode(response.body);
  debugPrint(response.body);
  return List<Item>.generate(responseJson.length, (int index) {
    final property = responseJson[index];
    return Item(
        headerValue: property['brand'] + property['model'],
        applianceType: property['appliance_type'],
        model: property['model'],
        brand: property['brand'],
        cons: property['cons'].toString(),
        price: property['price'].toString(),
        //expandedValue: 'This is item number $index',
        );
  });
}


class _ElectrodomesticoList extends State<ElectrodomesticoList> {
  //Se rellena  la lista de propiedades
  List<Item> _data =  [];
  
  TextEditingController nameController = TextEditingController();

  _ElectrodomesticoList() {
    generateItems().then((val) => setState(() {
          _data = val;
        }));
  }

  Future<void> moveToPropiedades(Item item) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('_actual_property', item.uuid);

    await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/appliances/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString('_user_token'),
      },
      body: <String, String>{
      "property":  prefs.getString('_actual_property'),
      "appliance_type": item.applianceType,
      "model":  item.model,
      "brand": item.brand,
      "cons":  item.cons,
      "price": item.price,
      }
    );
    Navigator.pop(context);
  }
  
  Future<void> newProperty() async {
    Navigator.pushNamed(context, '/new_appliance');
  }

  Widget _buildPanel()  {
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
              body: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                      title: const Text("Añadir a propiedad"),
                      onTap:() async {
                        moveToPropiedades(item);
                        },
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
          child: ListView(
            children: [
              Column(children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    left: 50,
                    top: 30,
                  ),
                  child: const CustomBackButton(buttonColor: Colors.black),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    left: 50,
                    top: 10,
                  ),
                  child: const Text(
                    'Electrodomesticos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    left: 50,
                    bottom: 50,
                  ),
                  child: const Text(
                    'Todos los electrodomésticos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  child: _buildPanel(),
                ),
                
                GeneralButton(title: "Custom", textColor: Colors.white, action: newProperty),
                const Padding(padding: EdgeInsets.only(bottom: 30))
              ]),
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
            )
          ),
        ),
    );
  }
}
