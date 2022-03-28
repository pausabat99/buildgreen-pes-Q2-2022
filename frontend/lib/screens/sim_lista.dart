// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SimuladorList extends StatefulWidget {
  const SimuladorList({Key? key}) : super(key: key);

  @override
  State<SimuladorList> createState() => _SimuladorListState();
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
    required this.id,
    required this.activeMorning,
    required this.activeAfternoon,
    required this.activeNight,
  });

  String id;
  String headerValue;
  bool isExpanded;
  bool activeMorning;
  bool activeAfternoon;
  bool activeNight;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
        id: '$index',
        headerValue: 'Electrodoméstico $index',
        activeMorning: false,
        activeAfternoon: false,
        activeNight: false);
  });
}

class _SimuladorListState extends State<SimuladorList> {
  final List<Item> electrodomesticos = generateItems(15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Text('SIMULACIÓN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
              ),
              SizedBox(
                height: 400,
                child: SingleChildScrollView(
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        electrodomesticos[index].isExpanded = !isExpanded;
                      });
                    },
                    children: electrodomesticos.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(item.headerValue),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 10, 10, 10),
                                        child: Text(
                                          'Selecciona el horario de uso:',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 30, 10),
                                      child: IconButton(
                                          onPressed: () => showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) =>
                                                    AlertDialog(
                                                  title: const Text('¡ATENCIÓN!'),
                                                  content: const Text(
                                                      '¿Quieres borrar este electrodoméstico?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancelar'),
                                                      child:
                                                          const Text('Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => {
                                                        Navigator.pop(
                                                            context, 'OK'),
                                                        setState(() {
                                                          electrodomesticos
                                                              .removeWhere((Item
                                                                      currentItem) =>
                                                                  item ==
                                                                  currentItem);
                                                        })
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          alignment: Alignment.centerRight,
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          icon: const Icon(Icons.delete)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: IconButton(
                                      icon: Icon(Icons.wb_sunny),
                                      color: item.activeMorning
                                          ? Colors.green
                                          : Colors.black,
                                      onPressed: () => setState(() {
                                        item.activeMorning = !item.activeMorning;
                                        },
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: IconButton(
                                        icon: Icon(Icons.brightness_4),
                                        color: item.activeAfternoon
                                            ? Colors.green
                                            : Colors.black,
                                        onPressed: () => setState(() {
                                              item.activeAfternoon =
                                                  !item.activeAfternoon;
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: IconButton(
                                        icon: Icon(Icons.brightness_2),
                                        color: item.activeNight
                                            ? Colors.green
                                            : Colors.black,
                                        onPressed: () => setState(() {
                                              item.activeNight =
                                                  !item.activeNight;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        isExpanded: item.isExpanded,
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    //padding: EdgeInsets.all(10)
                  ),
                  onPressed: () {},
                  child: Text('Añadir'),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    //padding: EdgeInsets.all(10)
                  ),
                  onPressed: () {},
                  child: Text('SIMULAR CONSUMO'),
                )
              )
            ],
          ),
        ),
    );
  }
}
