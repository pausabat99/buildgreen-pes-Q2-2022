import 'dart:convert';
import 'dart:async';

import 'package:buildgreen/screens/welcome_screen.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buildgreen/widgets/input_form.dart';

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
      //'lastname': apellidoController.text,
      'email': emailController.text,
      'password': passwordController.text,
      //'type': _character.toString(),
      },
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
      return Material (
        child: Stack(
          children: [
            // background colors start
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 27, 119, 58),
              ),
            ),
            Transform.scale(
              scale: 1.4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(-15 / 360),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                    color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(25),
            child: Image(
              image: const AssetImage('images/build_green_logo.png'),
              height: screenHeight * 0.125,
            ),
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
                      ElevatedButton(
                        
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal.withAlpha(0),
                          onPrimary: Colors.white.withAlpha(0),
                          shadowColor: Colors.black.withOpacity(0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                          elevation: 1
                        ),
                        onPressed: () => {Navigator.pop(context)},
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 45,),
                      ),


                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0 , 0, 0),
                        child: Text("Registro",
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
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                  alignment: Alignment.centerLeft,
                  
                  child: const Text(
                      "Tipo de usuario",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                ),

              const Divider(
                thickness: 2, // thickness of the line
                indent: 20, // empty space to the leading edge of divider.
                endIndent: 20, // empty space to the trailing edge of the divider.
                color: Colors.white70, // The color to use when painting the line.
                height: 5, // The divider's height extent.
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