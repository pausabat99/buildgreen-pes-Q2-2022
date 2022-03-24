// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:buildgreen/widgets/item_electrodomestico_borrable.dart';
import 'package:buildgreen/widgets/item_electrodomestico_noborrable.dart';
import 'package:flutter/material.dart';
class ElectrodomesticoList extends StatefulWidget {
  const ElectrodomesticoList({ Key? key }) : super(key: key);

  @override
  State<ElectrodomesticoList> createState() => _ElectrodomesticoListState();
}

class _ElectrodomesticoListState extends State<ElectrodomesticoList> {
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
                    'Lista de electrodomésticos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)
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
                    child: Text('Añadir nuevo electrodoméstico'),
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: ListView.separated(
                    itemCount : electrodomesticos.length,
                    itemBuilder:  (BuildContext context, int index) {
                      return ItemElectrodomesticoNoBorrable(title: electrodomesticos[index]);
                    } ,
                    padding: const EdgeInsets.all(8),
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
