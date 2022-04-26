import 'package:buildgreen/widgets/back_button.dart';
import 'package:buildgreen/widgets/general_background.dart';
import 'package:flutter/material.dart';
import 'package:buildgreen/screens/appliance_compare_screen.dart';

class ListaConsejosDia extends StatefulWidget {
  const ListaConsejosDia({ Key? key }) : super(key: key);

  @override
  State<ListaConsejosDia> createState() => _ListaConsejosDiaState();
}

class _ListaConsejosDiaState extends State<ListaConsejosDia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GeneralBackground(),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: panelDecoracion(),
                child: Column(
                  children: [
                    Row(
                      
                    )
                  ],
                )
              ),
            )
          ),
        ]
      )
    );
  }
}