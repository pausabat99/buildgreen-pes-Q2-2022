// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/widgets/general_background.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buildgreen/screens/lista_electrodomesticos.dart' as electr;


class CompareApplianceScreen extends StatelessWidget {

  static const route = '/compare';

  const CompareApplianceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    electr.Item? loaded_one;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GeneralBackground(),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 75, left: 0, right: 0),
              ),
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
              Expanded(child: Container(),),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                alignment: Alignment.bottomCenter,
                  child : GeneralButton(
                    title: 'Entrar', 
                    textColor: Colors.white , 
                    action: () => {Navigator.pushNamed(context, '/login')}
                  ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 100),
                alignment: Alignment.bottomCenter,
                child : GeneralButton(
                    
                    title: 'Registrarse', 
                    textColor: Colors.white , 
                    action: () => {Navigator.pushNamed(context, '/register')}
                  ),
              ),
            ],
          ),
        ],)
    );
  }
}

