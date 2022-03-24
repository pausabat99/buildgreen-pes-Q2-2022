import 'dart:math';

import 'package:buildgreen/screens/area_personal_cliente.dart';
import 'package:flutter/material.dart';

class ListaPropiedades extends StatefulWidget {
  const ListaPropiedades({Key? key}) : super(key: key);
  @override
  State<ListaPropiedades> createState() => _ListaPropiedades();
}

class _ListaPropiedades extends State<ListaPropiedades> {
  final List<String> popiedades = <String>[
    'Carrer Aragó, 127 08029 Barcelona',
  ];
  final List<int> idPropiedad = <int>[1];

  TextEditingController nameController = TextEditingController();

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AreaPersonalCliente()));
  }

  void addItemToList() {
    setState(() {
      int lastItemIndex = popiedades.length;

      popiedades.insert(lastItemIndex, "Nueva propiedad");
      idPropiedad.insert(lastItemIndex, Random().nextInt(100));
    });
  }

  @override
  Widget build(BuildContext context) {
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
          )),
        ),
        ListView(
          children: [
            Expanded(
              child: Column(children: <Widget>[
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 50,
                            top: 10,
                          ),
                          child: Image(
                            image: AssetImage("images/admin.png"),
                            height: 70,
                            width: 70,
                          ),
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
                        'Cartera de propiedades',
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
                            onTap: () {
                              _navigateToNextScreen(context);
                            },
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                itemCount: popiedades.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 140.0,
                                    margin: const EdgeInsets.only(
                                        left: 30.0,
                                        bottom: 20.0,
                                        top: 20.0,
                                        right: 30.0),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Flexible(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Image(
                                              image: AssetImage(
                                                  "images/propiedadadminverde.png"),
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 12,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${popiedades[index]} ',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Flexible(
                                          flex: 3,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(Icons.arrow_forward_ios,
                                                color: Color.fromARGB(
                                                    255, 94, 95, 94)),
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  );
                                })))
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Nueva propiedad',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: TextButton.styleFrom(
                              primary: const Color.fromARGB(255, 3, 68, 28)),
                          onPressed: () {
                            addItemToList();
                          },
                        ),
                      ),
                    ]),
              ]),
            ),
          ],
        ),
      ],
    ));
  }
}
