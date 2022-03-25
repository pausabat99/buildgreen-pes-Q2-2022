// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'dart:async';

import 'package:buildgreen/screens/main_screen.dart';
import 'package:buildgreen/screens/signup_screen.dart';
import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/build_green_form_background.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buildgreen/widgets/input_form.dart';

import 'package:shared_preferences/shared_preferences.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({ Key? key }) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String output = "hola";

  bool processing = false;


  Future<void> logInReqAccount() async {
    if (processing) return; 
    processing = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("RRequesting");
    debugPrint(prefs.getString('_user_token'));
    final response = await http.post(
      Uri.parse('https://buildgreen.herokuapp.com/login/'),
      body: {
        'username': emailController.text,
        'password': passwordController.text,
      },
    );
    
    final responseJson = jsonDecode(response.body);
    if (responseJson['token'] != null){
      await prefs.setString('_user_token', responseJson['token']);
      processing = false;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
        return const MainScreen();
          }
        )
      );
    }
    processing = false;
  }

  
  void logInAccount()  { 
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return const MainScreen();
        }
      )
    );
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
              backColor: const Color.fromARGB(255, 39, 170, 83),
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
                        padding: const EdgeInsets.fromLTRB(10, 0 , 10, 0),
                        child: Text("Log in",
                          textAlign: TextAlign.left, 
                          style: Theme.of(context).textTheme.headline1,
                          
                        ),
                      ),
                    ]
                  ),
                ),
                
                InputForm(controller: emailController, hintLabel: "Email"),
                
                InputForm(controller: passwordController, hintLabel: "Password", obscureText: true,),
                
                const Padding(padding: EdgeInsets.only(top: 20)),
                
                GeneralButton(
                    title: "Entrar",
                    action: logInReqAccount,
                    textColor: Colors.white,
                ),

                const Padding(padding: EdgeInsets.all(10)),
                Text("o", style: Theme.of(context).textTheme.bodyText1,),
                const Padding(padding: EdgeInsets.all(10)),
                TextButton(
                  onPressed: () => {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                                  return const SignUpScreen();
                                  }
                              )
                           )
                          },
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Colors.lightGreen.shade100,
                      fontSize: 18
                    ),
                  ),
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

