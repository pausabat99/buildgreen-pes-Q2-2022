// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildgreen/widgets/item_electrodomestico.dart';
import 'package:flutter/material.dart';
class SimuladorList extends StatefulWidget {
  const SimuladorList({ Key? key }) : super(key: key);

  @override
  State<SimuladorList> createState() => _SimuladorListState();
}

class _SimuladorListState extends State<SimuladorList> {
  final List<String> electrodomesticos = ["Elec1", "Elec2","Elec3","Elec4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          SizedBox(
            height: double.infinity,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                SizedBox(
                  height: 100, 
                  child: Text(
                    'SIMULACIÓN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: ListView.separated(
                    itemCount : electrodomesticos.length,
                    itemBuilder:  (BuildContext context, int index) {
                      return ItemElectrodomestico(title: electrodomesticos[index]);
                    } ,
                    padding: const EdgeInsets.all(8),
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      //padding: EdgeInsets.all(10)
                    ),
                    onPressed: () {
                      
                     },
                    child: Text('Añadir'),
                  ),
                ),
              ],
            ),
          ),
    );

  }
}
