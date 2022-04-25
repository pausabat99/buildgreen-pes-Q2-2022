// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/general_background.dart';
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
  final List<Item> allObjects;

  const CompareApplianceScreen(
    {
      Key? key,
      required this.startObject,
      required this.allObjects
    }
  ) :super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
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
                  Expanded(
                    flex:  3,
                    child: Row(
                      children:  [
                        // First item 
                        Expanded( 
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ApplianceDetail(appliance: startObject),
                                      ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),

                        Expanded( 
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ApplianceDetail(appliance: (allObjects..shuffle()).first),
                                      ],
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
                    ),
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class ApplianceDetail extends StatelessWidget {
  const ApplianceDetail({
    Key? key,
    required this.appliance,
  }) : super(key: key);

  final Item appliance;

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: Container(
              decoration: panelDeoraction(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  

                  // BRAND AND NAME
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      const Image(
                        image: AssetImage("assets/images/electrodomestico.png"),
                      ),
                      const Padding(padding: EdgeInsets.all(10)),
                      Text(appliance.brand),
                      Text(appliance.headerValue),
                    ],
                  ),


                  // POWER CONSUMPTION
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      const Text("Price",       style: TextStyle(color: Colors.grey, fontSize: 20),),
                      Text(appliance.price),
                      const Padding(padding: EdgeInsets.all(5)),
                      const Text("Power [KW]",  style: TextStyle(color: Colors.grey, fontSize: 20)),
                      Text(appliance.cons)
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

