import 'dart:convert';

import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

// ignore: library_prefixes
import 'package:buildgreen/constants.dart' as Constants;

import 'package:shared_preferences/shared_preferences.dart';

class BuildingView extends StatefulWidget {
  static const route = "/building_view";

  const BuildingView({Key? key}) : super(key: key);

  @override
  State<BuildingView> createState() => _BuildingView();
}

class Item {
  Item({
    required this.name,
    required this.address,
    required this.user,
    required this.apt,
    required this.postalCode,
    required this.propertyType,
    required this.size,
    this.isExpanded = false,
    this.uuid,
  });

  String name;
  String address;
  String user;
  String apt;
  String postalCode;
  String propertyType;
  String size;
  bool isExpanded;
  String? uuid;
}

Future<List<Item>> generateItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(Constants.API_ROUTE +
        '/buildings/' +
        prefs.getString("current_building")),
    headers: <String, String>{
      HttpHeaders.authorizationHeader:
          "Token " + prefs.getString("_user_token"),
    },
  );

  final responseJson = jsonDecode(response.body);
  debugPrint(response.body);
  debugPrint(response.body);

  return List<Item>.generate(responseJson.length, (int index) {
    final property = responseJson['properties'];
    return Item(
      name: property['name'],
      address: property['address'],
      user: property['user'],
      apt: property['apt'],
      postalCode: property['postal_code'],
      propertyType: property['property_type'],
      uuid: property['uuid'],
      size: property['property_size'],
    );
  });
}

class _BuildingView extends State<BuildingView> {
  List<Item> _data = [];

  vincularPropiedad() {}

  desvincularPropiedad(Item item) {}

  _BuildingView() {
    generateItems().then((val) => setState(() {
          _data = val;
        }));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        for (var foo in _data) {
          if (_data[index] != foo) foo.isExpanded = false;
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
                image: AssetImage("assets/images/propiedadadminverde.png"),
                height: 100,
                width: 100,
              ),
              title: Text(item.address),
            );
          },
          body: ListView(
            shrinkWrap: true,
            children: [
              const ListTile(
                title: Text("Nombre de la propiedad"),
              ),
              ListTile(
                title: const Text("Desvincular Propiedad"),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('¡ATENCIÓN!'),
                    content: const Text(
                        '¿Quieres desvincular la propiedad de tu edificio?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancelar'),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await desvincularPropiedad(item);
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
                'Propiedades',
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
                'Cartera de propiedades',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              child: _buildPanel(),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            GeneralButton(
                title: "Vincular propiedad",
                textColor: Colors.white,
                action: vincularPropiedad),
            const Padding(padding: EdgeInsets.only(bottom: 30))
          ]),
        ],
      ),
    );
  }
}
