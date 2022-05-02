
// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:buildgreen/screens/classes/advice.dart';
import 'package:buildgreen/widgets/back_button.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: library_prefixes
import 'package:buildgreen/constants.dart' as Constants;

class ConsejosList extends StatefulWidget {

  static const route = "/my_advices";
  
  const ConsejosList({Key? key}) : super(key: key);

  @override
  State<ConsejosList> createState() => _ConsejosList();
}

//Generar propiedades para la Expansion Panel List
Future<List<Advice>> generateItems(String param) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  EasyLoading.show(status: 'Carg',maskType: EasyLoadingMaskType.black);

  final response = await http.get(
      Uri.parse(Constants.API_ROUTE+'/advices_user/'+param),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
      },
  );

  final responseJson = jsonDecode(response.body);
  EasyLoading.dismiss();
  debugPrint(response.body);

  return List<Advice>.generate(responseJson.length, (int index) {
    final property = responseJson[index];
    final timeSlots = property['time_options'].split(" ");
    final timeOptions = List<int>.generate(timeSlots.length, (int index) {
      return int.parse(timeSlots[index]);
    });
    return Advice(
        title: property['title'],
        id: property['uuid'],
        description: property['description'],
        xps: property['xps'],
        timeOptions: timeOptions,
    );
  });
}
class _ConsejosList extends State<ConsejosList> {
  //Se rellena  la lista de propiedades
  List<Advice> _unCompletedAdvices =  [];
  List<Advice> _completedAdvices =  [];
  
  TextEditingController nameController = TextEditingController();

  _ConsejosList() {
    generateItems('to_complete').then((val) => setState(() {
          _unCompletedAdvices = val;
        },
      ),
    );

    generateItems('completed').then((val) => setState(() {
          _completedAdvices = val;
        },
      ),
    );

  }

  
  Future<void> allAdvices() async {
    setState(() {
      Navigator.pushNamed(context, '/all_advices');  
    });
    
  }

  Widget _buildPanel()  {
    return ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            for (var tItem in _unCompletedAdvices ) {
              if(_unCompletedAdvices[index] != tItem) {
                tItem.isExpanded = false;
              } 
            }
            setState(() {
              _unCompletedAdvices[index].isExpanded = !isExpanded;
            });
          },
          children: _unCompletedAdvices.map<ExpansionPanel>((Advice item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text("Uncompleted advices"),
            );
          },
          body: ListTile(
            title: Column(
                children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Marca: '+item.title, textAlign: TextAlign.left),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, '/advice_detail', arguments: item);
                          });
                        }, 
                        icon: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }
      ).toList()..addAll(
        _completedAdvices.map<ExpansionPanel>((Advice item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text("Uncompleted advices"),
            );
          },
          body: ListTile(
            title: Column(
                children: [
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Marca: '+item.title, textAlign: TextAlign.left),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(context, '/advice_detail', arguments: item);
                          });
                        }, 
                        icon: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  )
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }
      )
      ),
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
                    'Consejos de sostenibilidad',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                Container(
                  child: _buildPanel(),
                ),
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