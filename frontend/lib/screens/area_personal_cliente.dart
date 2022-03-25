// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/screens/welcome_screen.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class AreaPersonalCliente extends StatefulWidget {
  const AreaPersonalCliente({Key? key}) : super(key: key);
  @override
  State<AreaPersonalCliente> createState() => _AreaPersonalCliente();
}

class _AreaPersonalCliente extends State<AreaPersonalCliente> {

  bool processing = false;

  Future<void> onPressedLogOut() async {
    if (processing) return;
    processing = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.post(
    Uri.parse('https://buildgreen.herokuapp.com/logout/'),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
      },
    );
    Navigator.of(context).push( MaterialPageRoute(builder: (_) { return const WelcomeScreen(); } ) );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 50,
                          ),
                          child: Text(
                            'ÁREA PERSONAL',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                        child: Text(
                          'Carrer de Rosello, 1\n08029 Barcelona',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 190.0,
                            height: 190.0,
                            margin: const EdgeInsets.all(50.0),
                            padding: const EdgeInsets.all(10.0),
                            child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 94, 95, 94)),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 190.0,
                          height: 190.0,
                          margin: const EdgeInsets.all(50.0),
                          padding: const EdgeInsets.all(10.0),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 94, 95, 94)),
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 50,
                          ),
                          child: Text(
                            'Precios a tiempo real',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 70.0,
                          margin: const EdgeInsets.all(50.0),
                          padding: const EdgeInsets.all(10.0),

                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Flexible(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image(
                                    image: AssetImage("assets/images/euro.png"),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 10,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Ver precios a tiempo real',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 94, 95, 94)),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 50,
                          ),
                          child: Text(
                            'Consumo energetico',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 400.0,
                          margin: const EdgeInsets.all(50.0),
                          padding: const EdgeInsets.all(10.0),
                          child: const Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "assets/images/cual_es_el_gasto_en_electricidad2.png"),
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: 50,
                            ), // use Spacer
                          ),
                        ),
                      ]),
                ],
              ),
            GeneralButton(
                    title: "Log out",
                    action: onPressedLogOut,
                    textColor: Colors.black,
            ),
            const Padding(padding: EdgeInsets.only(
              top: 20
            ))
          ],
        ),
    );
  }
}
