import 'dart:convert';
import 'dart:async';

import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/input_form.dart';
import '../widgets/general_buttom.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({ Key? key }) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> logInAccount() async {
    final response = await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/api-token-auth'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      'email': emailController.text,
      'password': passwordController.text,
      },
      ),
    );

    final responseJson = jsonDecode(response.body);
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
                color: Color.fromARGB(255, 39, 170, 83),
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
                  child: Text("Log in",
                  textAlign: TextAlign.left, 
                  style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                
                InputForm(controller: emailController, hintLabel: "Email"),
                
                InputForm(controller: passwordController, hintLabel: "Password", obscureText: true,),
                
                const Padding(padding: EdgeInsets.only(top: 20)),

                const Padding(padding: EdgeInsets.only(top: 20)),
                
                GeneralButton(
                    title: "Entrar",
                    action: logInAccount,
                    textColor: Colors.white,
                    )
              ],
            ),
          )
          // form end
        ],
      ),
    );
  }
}