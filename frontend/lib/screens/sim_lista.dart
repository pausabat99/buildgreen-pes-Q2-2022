// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildgreen/widgets/item_electrodomestico_borrable.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';

class SimuladorList extends StatefulWidget {
  const SimuladorList({Key? key}) : super(key: key);

  @override
  State<SimuladorList> createState() => _SimuladorListState();
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
    required this.id,
  });
  String id;
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      id: '$index',
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
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
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: 1.9,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 10, 10, 10),
                                      child: Text('Selecciona el horario:'),
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
                                                      electrodomesticos.removeWhere(
                                                          (Item currentItem) => item == currentItem);
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
                            children: <Widget>[
                              SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: Icon(Icons.wb_sunny)),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Icon(Icons.brightness_4),
                              ),
                              SizedBox(
                                height: 50,
                                width: 100,
                                child: Icon(Icons.brightness_2),
                              )
                            ],
                          )
                        ],
                      ),
                      /*body: ListTile(
                          title: Text(item.expandedValue),
                          subtitle: const Text(
                              'To delete this panel, tap the trash can icon'),
                          trailing: const Icon(Icons.delete),
                          onTap: () {
                            setState(() {
                              electrodomesticos.removeWhere(
                                  (Item currentItem) => item == currentItem);
                            });
                          }),*/
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ),
            ),
            /*child: ListView.separated(
                    itemCount : electrodomesticos.length,
                    itemBuilder:  (BuildContext context, int index) {
                      return ItemElectrodomesticoBorrable(title: electrodomesticos[index]);
                    } ,
                    padding: const EdgeInsets.all(8),
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),*/
            SizedBox(
              height: 100,
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
          ],
        ),
      ),
    );
  }
}
