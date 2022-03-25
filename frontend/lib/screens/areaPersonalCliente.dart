import 'package:flutter/material.dart';

class AreaPersonalCliente extends StatefulWidget {
  const AreaPersonalCliente({Key? key}) : super(key: key);
  @override
  State<AreaPersonalCliente> createState() => _AreaPersonalCliente();
}

class _AreaPersonalCliente extends State<AreaPersonalCliente> {
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
              flex: 3,
              child: Column(
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
                          onTap: () {
                            print('GestureDetector onTap Called');
                          },
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
                              color: Color.fromARGB(255, 255, 255, 255),
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
                            color: Color.fromARGB(255, 255, 255, 255),
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
                          //width: 190.0,
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
                                    image: AssetImage("images/euro.png"),
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
                            color: Color.fromARGB(255, 255, 255, 255),
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
                                "images/cual_es_el_gasto_en_electricidad2.png"),
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextButton.icon(
                            icon: const Icon(Icons.power_settings_new),
                            label: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            style: TextButton.styleFrom(
                                primary: Color.fromARGB(255, 3, 68, 28)),
                            onPressed: () {},
                          ),
                        ),
                      ])
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
