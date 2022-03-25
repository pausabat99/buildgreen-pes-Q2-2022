// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login_screen.dart';
import './signup_screen.dart';
import "../widgets/general_buttom.dart";

class WelcomeScreen extends StatelessWidget {

  static const routeName = '/welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  Future<void> logInReqAccount(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString("_user_token") != null){
     final http.Response response = await http.get(
      Uri.parse('https://buildgreen.herokuapp.com/user/'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
        },
      );

      final responseJson = jsonDecode(response.body);
      if (responseJson['user_info'] != null) {
        Navigator.of(context).push( MaterialPageRoute(builder: (_) { return const MainScreen(); } ) );
      }
      else {
        await prefs.remove("_user_token");
      }
    }
  }

        

  @override
  Widget build(BuildContext context) {
    logInReqAccount(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
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

          Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 75, left: 0, right: 0),
                    ),
                    Stack(
                      children: <Widget>[
                        // background profilePic start
                        Container(
                           padding: EdgeInsets.only(top: screenHeight*0.35, left: 50, right: 50),

                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/build_green_logo.png",
                              ),
                            ),
                          ),
                        ),
                        // background profilePic end
                      ]
                    ),
                    const Expanded(child: Text(""),),
                    Container(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.bottomCenter,
                        child : GeneralButton(
                          title: 'Entrar', 
                          textColor: Colors.white , 
                          action: () => {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                                  return const LogInScreen();
                                  }
 
                              )
                           )
                          }
                        ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 150),
                      alignment: Alignment.bottomCenter,
                      child : GeneralButton(
                          
                          title: 'Registrarse', 
                          textColor: Colors.white , 
                          action: () => {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                                  return const SignUpScreen();
                                  }
                              )
                           )
                          }
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],)
    );
  }
}