// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/general_background.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buildgreen/screens/sim_lista.dart';

BoxDecoration panelDeoraction(){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: const [BoxShadow(
      color: Colors.black45, 
      blurRadius: 5,
      offset: Offset(3, 3),
      ),
    ],
  );
}

class CompareApplianceScreen extends StatelessWidget {

  final Item startObject; 

  const CompareApplianceScreen({Key? key, required this.startObject}):super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    Item? loaded_one;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return SafeArea(
      child: Scaffold(
        body: Stack(

          children: [
            const GeneralBackground(),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // HEADER
                  Row(
                    children:  [
                      const CustomBackButton(),
                      const Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Cambio",
                        style: Theme.of(context).textTheme.headline2,
                        )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  // List of 
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: panelDeoraction(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const Image(
                                  image: AssetImage("assets/images/electrodomestico.png"),
                                ),

                                // BRAND AND NAME
                                Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(startObject.brand),
                                    Text(startObject.headerValue),
                                  ],
                                ),

                                Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(startObject.brand),
                                    Text(startObject.headerValue),
                                  ],
                                ),

                                // POWER CONSUMPTION
                                Flex(
                                  direction: Axis.vertical,
                                  children: [
                                    const Text("Price",       style: TextStyle(color: Colors.grey, fontSize: 20),),
                                    Text(startObject.price),
                                    const Padding(padding: EdgeInsets.all(5)),
                                    const Text("Power [KW]",  style: TextStyle(color: Colors.grey, fontSize: 20)),
                                    Text(startObject.cons)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                          child: Container(
                            decoration: panelDeoraction(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  width: 0.3* screenWidth,
                                  image: const AssetImage("assets/images/build_green_logo.png"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: panelDeoraction(),
                    )
                    ,)
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}

