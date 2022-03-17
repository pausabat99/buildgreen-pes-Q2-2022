import 'package:buildgreen/widgets/item_electrodomestico.dart';
import 'package:flutter/material.dart';
class SimuladorList extends StatefulWidget {
  const SimuladorList({ Key? key }) : super(key: key);

  @override
  State<SimuladorList> createState() => _SimuladorListState();
}

class _SimuladorListState extends State<SimuladorList> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            color: Colors.green,
          ),
          Column(

            children: <Widget>[
              ItemElectrodomestico(title: "Hello world"),
              ItemElectrodomestico(title: "Hello world"),
              ItemElectrodomestico(title: "Hello world"),
              ItemElectrodomestico(title: "Hello world"),
              ItemElectrodomestico(title: "Hello world"),
            ],
          ),
        ],
      ),
    );
  }
}