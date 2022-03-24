import 'dart:convert';
import 'dart:async';

import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/build_green_form_background.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buildgreen/widgets/input_form.dart';

class NewAppliance extends StatefulWidget {
  const NewAppliance({ Key? key }) : super(key: key);

  @override
  State<NewAppliance> createState() => _NewApplianceState();
}

class _NewApplianceState extends State<NewAppliance> {

  TextEditingController nameController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String output = "Hola";

  String? _character = "client";

  Future<void> createAccount() async {
    final response = await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/signup/'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'username': nameController.text,
      'first_name': nameController.text,
      'last_name': apellidoController.text,
      'email': emailController.text,
      'password': passwordController.text,
      },
      ),
    );
    debugPrint(response.body);
    setState(() {
      output = response.body;
    });
    final responseJson = jsonDecode(response.body);
  }

  Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.white;
  }

  String dropdownValue = 'Horno';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
      return Material (
        child: Stack(
          children: [
            // background colors start
            BackgroundForm(
              screenHeight: screenHeight,
              backColor: const Color.fromARGB(255, 71, 146, 96),
            ),
            // background colors end
            // form start
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: const CustomBackButton(),
                  ),
                  
                  Row(children: <Widget>[
                    InputForm(controller: nameController, hintLabel: 'Nombre'),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Transform.translate(
                      offset: const Offset(0, 12),
                      child: DropdownButton<String>(
                        alignment: Alignment.topCenter,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward, color: Colors.white,),
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
                        items: <String>['Horno', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        dropdownColor: Colors.green,
                      ),
                    ),
                    //InputForm(controller: apellidoController, hintLabel: "Apellidos"),
                    ],
                  ),
                  
                  InputForm(controller: emailController, hintLabel: "Precio"),
                  
                  InputForm(controller: passwordController, hintLabel: "Consumo"),
                  
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                        "Medidas",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                  ),
                  
                  Row(children: <Widget>[
                    InputForm(controller: nameController, hintLabel: 'Alto'),
                    InputForm(controller: nameController, hintLabel: 'Ancho'),
                    InputForm(controller: nameController, hintLabel: 'Largo'),
                    //InputForm(controller: apellidoController, hintLabel: "Apellidos"),
                    ],
                  ),
                  InputForm(controller: passwordController, hintLabel: "Peso"),

                  GeneralButton(
                      title: "Agregar nuevo",
                      action: () {int count = 0;
                                  Navigator.of(context).popUntil((_) => count++ >= 2);
                                  },
                      textColor: Colors.white,
                  ),
                  Text(output),
                ],
              ),
            )
          // form end
        ],
      ),
    );
  }
}