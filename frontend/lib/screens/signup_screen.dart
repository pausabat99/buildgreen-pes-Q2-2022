// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:async';

import 'package:buildgreen/screens/main_screen.dart';
import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/build_green_form_background.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buildgreen/widgets/input_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
      'is_admin': 'False',
      'license_num': '',
      },
      ),
    );
    debugPrint(response.body);
    setState(() {
      output = response.body;
    });
    final responseJson = jsonDecode(response.body);
    if (responseJson['user_info'] != null){
      final response = await http.post(
        Uri.parse('https://buildgreen.herokuapp.com/login/'),
        body: {
          'username': nameController.text,
          'password': passwordController.text, 
        }
      );
      debugPrint(response.body);
      setState(() {
        output = response.body;
      });
      
      final responseJson = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('_user_token', responseJson['token']);
      Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return const MainScreen();
        }
      )
    );
      //
    }
    else {
      debugPrint("NUUU");
    }
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
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
      return Material (
        child: Stack(
          children: [
            // background colors start
            BackgroundForm(
              screenHeight: screenHeight,
              backColor: const Color.fromARGB(255, 27, 119, 58),
            ),
            // background colors end
            // form start
            Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child: Row(
                      
                      children: [
                        const CustomBackButton(),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0 , 0, 0),
                          child: Text("Sign Up",
                            textAlign: TextAlign.left, 
                            style: Theme.of(context).textTheme.headline1,
                            
                          ),
                        ),
                      ]
                    ),
                  ),
                  
                  Row(children: <Widget>[
                    InputForm(controller: nameController, hintLabel: 'Nombre'),
                    
                    InputForm(controller: apellidoController, hintLabel: "Apellidos"),
                    ],
                  ),
                  
                  InputForm(controller: emailController, hintLabel: "Email"),
                  
                  InputForm(controller: passwordController, hintLabel: "Password", obscureText: true,),
                  
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    alignment: Alignment.centerLeft,
                    
                    child: const Text(
                        "Tipo de usuario",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                  ),

                  
                ListTile(
                  title: Text(
                    'Cliente',
                    style: Theme.of(context).textTheme.bodyText1
                  ),

                  leading: Radio<String>(
                    value: "client",
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    groupValue: _character,
                    onChanged: (String? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: Text(
                    'Administrador de propiedades',
                    style: Theme.of(context).textTheme.bodyText1
                  ),
                  leading: Radio<String>(
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: "prop_admin",
                    groupValue: _character,
                    onChanged: (String? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),

                GeneralButton(
                    title: "Crear Cuenta",
                    action: createAccount,
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