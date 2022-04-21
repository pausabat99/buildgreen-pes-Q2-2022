import 'package:buildgreen/service_subscriber.dart';
import 'package:flutter/material.dart';
import 'package:buildgreen/widgets/input_form.dart';
import 'package:buildgreen/widgets/build_green_form_background.dart';
import 'package:buildgreen/widgets/back_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:buildgreen/widgets/general_buttom.dart';

class NewProperty extends StatefulWidget {
  const NewProperty({Key? key}) : super(key: key);

  @override
  State<NewProperty> createState() => _NewPropertyState();
}

class _NewPropertyState extends State<NewProperty> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apartamentoController = TextEditingController();
  TextEditingController cPostalController = TextEditingController();

  final backendtranslate = <String, String>{
    "Apartamento": "apt",
    "Edificio": "building",
    "Casa": "house",
  };
  String dropdownValue = 'Apartamento';

  String location = "Buscar dirección";


  Future<void> moveToPropiedades() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await http.post(Uri.parse('https://buildgreen.herokuapp.com/properties/'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              "Token " + prefs.getString('_user_token'),
        },
        body: <String, String>{
          "address": location,
          "name": nombreController.text,
          "property_type": backendtranslate[dropdownValue].toString(),
          "apt": apartamentoController.text,
          "postal_code": cPostalController.text,
        });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: Stack(
        children: [
          BackgroundForm(
            screenHeight: screenHeight,
            backColor: const Color.fromARGB(255, 71, 146, 96),
          ),
          Container(
              padding: const EdgeInsets.all(40),
              child: Column(children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: const CustomBackButton(),
                ),
                Stack(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Buscar dirección",
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => applicationBloc.searchPlaces(value),
                    ),
                    if (applicationBloc.searchResults.isNotEmpty) 
                        Container(
                          height: 300.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.6),
                              backgroundBlendMode: BlendMode.darken),
                          child: ListView.builder(
                            itemCount: applicationBloc.searchResults.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                  applicationBloc
                                      .searchResults[index].description.toString(),
                                  style: const TextStyle(color: Colors.white)))
                            ),
                        ),
                        Container(
                          height: 300.0,
                          child: ListView.builder(
                            itemCount: applicationBloc.searchResults.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                  applicationBloc
                                      .searchResults[index].description.toString(),
                                  style: const TextStyle(color: Colors.white)))
                            ),
                        )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputForm(
                        controller: nombreController, hintLabel: 'Nombre'),
                    Transform.translate(
                      offset: const Offset(0, 12),
                      child: DropdownButton<String>(
                        alignment: Alignment.topCenter,
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        style: Theme.of(context).textTheme.bodyText1,
                        underline: Container(
                          height: 3,
                          color: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['Apartamento', 'Edificio', 'Casa']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        dropdownColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                InputForm(
                    controller: apartamentoController,
                    hintLabel: 'Apartamento'),
                InputForm(
                    controller: cPostalController, hintLabel: 'Codigo postal'),
                GeneralButton(
                  title: "Agregar nuevo",
                  action: moveToPropiedades,
                  textColor: Colors.white,
                ),
              ]))
        ],
      ),
    );
  }
}
