import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:buildgreen/screens/main_screen.dart';
import 'package:buildgreen/screens/signup_screen.dart';
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

  


  Future<void> logInReqAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("_user_token") != null){
     final http.Response response = await http.get(
      Uri.parse('https://buildgreen.herokuapp.com/user/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
        },
      );
      setState(() {
        output = response.body;
      });
    }

    else {
      final response = await http.post(
        Uri.parse('https://buildgreen.herokuapp.com/login/'),
        // Send authorization headers to the backend.
        body: {
          'username': emailController.text,
          'password': passwordController.text,
        },
      );
      setState(() {
        output = response.body;
      });
      
      final responseJson = jsonDecode(response.body);
      prefs.setString('_user_token', responseJson['token']);
    }
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
                        padding: const EdgeInsets.fromLTRB(20, 0 , 0, 0),
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