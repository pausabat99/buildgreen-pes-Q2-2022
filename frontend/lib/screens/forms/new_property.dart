import 'package:buildgreen/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:buildgreen/widgets/input_form.dart';
import 'package:buildgreen/widgets/build_green_form_background.dart';
import 'package:buildgreen/widgets/back_button.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import '../../widgets/general_buttom.dart';

const kGoogleApiKey = "AIzaSyBygQuyllYYghJsQIOyQmYPqGlYtiLMGM0";

class NewProperty extends StatefulWidget {
  NewProperty({Key? key}) : super(key: key);

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
          "address": nombreController.text,
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
    return Material(
      child: Stack(
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
                InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: kGoogleApiKey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'es')],
                        onError: (err) {
                          print(err);
                        });

                    if (place != null) {
                      setState(() {
                        location = place.description.toString();
                      });

                      //from google_maps_webservice package
                      final plist = GoogleMapsPlaces(
                        apiKey: kGoogleApiKey,
                        apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //from google_api_headers package
                      );
                      String placeId = place.placeId ?? "0";
                      final detail = await plist.getDetailsByPlaceId(placeId);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          title: Text(location),
                          trailing: Icon(Icons.search),
                          dense: true,
                        ),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputForm(controller: nombreController, hintLabel: 'Nombre'),
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
