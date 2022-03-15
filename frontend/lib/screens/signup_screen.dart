import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  String? _character = "client";

  Future<void> createAccount() async {
    final response = await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/api-token-auth'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'username': nameController.text,
      'surname': apellidoController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'type': _character.toString(),
      },
      ),
    );

    final responseJson = jsonDecode(response.body);

  }
  @override
  Widget build(BuildContext context) {
      return Material (
        child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                //padding: const EdgeInsets.all(10),
                child: const Image(image: AssetImage("images/build_green_logo.png"))
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: apellidoController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Apellidos',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),

                        Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            ListTile(
              title: const Text('Cliente'),
              leading: Radio<String>(
                value: "client",
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Administrador de propuedades'),
              leading: Radio<String>(
                value: "prop_admin",
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Crear cuenta'),
                onPressed: createAccount,
              )
            ),
          ],
        ),
      ),
    );
  }
}