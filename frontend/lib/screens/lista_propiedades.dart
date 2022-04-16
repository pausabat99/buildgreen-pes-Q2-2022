// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListaPropiedades extends StatefulWidget {
  const ListaPropiedades({Key? key}) : super(key: key);

  @override
  State<ListaPropiedades> createState() => _ListaPropiedades();
}

//Classe Item Propiedad
class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
    this.uuid,
  });

  String headerValue;
  bool isExpanded;
  String? uuid;
}

//Generar propiedades para la Expansion Panel List
Future<List<Item>> generateItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse('https://buildgreen.herokuapp.com/properties/'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader:
          "Token " + prefs.getString("_user_token"),
    },
  );

  final responseJson = jsonDecode(response.body);
  debugPrint(response.body);
  return List<Item>.generate(responseJson.length, (int index) {
    final property = responseJson[index];
    return Item(headerValue: property['address'], uuid: property['uuid']
        //expandedValue: 'This is item number $index',
        );
  });
}

List<Item> generateItems2(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(headerValue: 'Calle Falsa 123'

        //expandedValue: 'This is item number $index',
        );
  });
}

class _ListaPropiedades extends State<ListaPropiedades> {
  //Se rellena  la lista de propiedades
  List<Item> _data = [];

  TextEditingController nameController = TextEditingController();

  _ListaPropiedades() {
    generateItems().then((val) => setState(() {
          _data = val;
        }));
  }

  Future<void> moveToAppliances(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('_actual_property', item.uuid);
    Navigator.pushNamed(context, '/sim');
  }

  Future<void> newProperty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/properties/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader:
            "Token " + prefs.getString("_user_token"),
      },
      body: {
        "address":
            AppLocalizations.of(context)!.calle + " " + _data.length.toString(),
        "property_type": "apt"
      },
    );

    setState(() {
      int lastItemIndex = _data.length;
      Item nitem = Item(
          headerValue: AppLocalizations.of(context)!.calle +
              " " +
              _data.length.toString());
      _data.insert(lastItemIndex, nitem);
    });
  }

  Future<void> deleteProperty(Item item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
        Uri.parse('https://buildgreen.herokuapp.com/properties/'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              "Token " + prefs.getString("_user_token"),
        },
        body: <String, String>{
          'uuid': item.uuid.toString(),
        });

    debugPrint(response.body);
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
                  title: Text(AppLocalizations.of(context)!.abrirpropiedad),
                  onTap: () async {
                    moveToAppliances(item);
                  }),
              ListTile(
                title: Text(AppLocalizations.of(context)!.eliminarpropiedad),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.atencion),
                    content: Text(
                        AppLocalizations.of(context)!.quieresborrarpropiedad),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(
                            context, AppLocalizations.of(context)!.cancelar),
                        child: Text(AppLocalizations.of(context)!.cancelar),
                      ),
                      TextButton(
                        onPressed: () async {
                          await deleteProperty(item);
                          setState(() {
                            _data.removeWhere(
                                (Item currentItem) => item == currentItem);
                          });
                          Navigator.pop(
                              context, AppLocalizations.of(context)!.ok);
                        },
                        child: Text(AppLocalizations.of(context)!.ok),
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
              child: Text(
                AppLocalizations.of(context)!.propiedades,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                bottom: 50,
              ),
              child: Text(
                AppLocalizations.of(context)!.carterapropiedades,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              child: _buildPanel(),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            GeneralButton(
                title: AppLocalizations.of(context)!.anpropiedad,
                textColor: Colors.white,
                action: newProperty),
            const Padding(padding: EdgeInsets.only(bottom: 30))
          ]),
        ],
      ),
    );
  }
}
