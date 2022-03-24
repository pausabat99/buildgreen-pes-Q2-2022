// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildgreen/widgets/item_electrodomestico_borrable.dart';
import 'package:flutter/material.dart';

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
                      body: ListTile(
                          title: Text(item.expandedValue),
                          subtitle: const Text(
                              'To delete this panel, tap the trash can icon'),
                          trailing: const Icon(Icons.delete),
                          onTap: () {
                            setState(() {
                              electrodomesticos.removeWhere(
                                  (Item currentItem) => item == currentItem);
                            });
                          }),
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
