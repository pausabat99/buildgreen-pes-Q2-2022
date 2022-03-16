import 'package:flutter/material.dart';

class AreaPersonalCliente extends StatelessWidget {
  const AreaPersonalCliente({Key? key}) : super(key: key);

  Widget authentificationButton(
      String title, Color textColor, BuildContext ctx) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 25, left: 50, right: 50),
      child: ElevatedButton(
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
            elevation: 1),
        onPressed: () {
          Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
            return const AreaPersonalCliente();
          }));
        },
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
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
              flex: 3,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          'AREA PERSONAL',
                        ),
                      ),
                      Expanded(
                        child: Image(
                          image: AssetImage("images/admin.png"),
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          'Carrer de Rosello, 1 \n 08029 Barcelona',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
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
                        child: Text(
                          'Precios a tiempo real',
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
                            children: const <Widget>[
                              Expanded(
                                child: Image(
                                  image: AssetImage("images/euro.png"),
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Ver precios a tiempo real',
                                ),
                              ),
                              Expanded(
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 94, 95, 94)),
                              ),
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
                        child: Text(
                          'Consumo energetico',
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
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
