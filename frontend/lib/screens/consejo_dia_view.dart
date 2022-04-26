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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3,3,),
                                    blurRadius: 5.0,
                                  )
                                ],
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                              ),
                            child: Center(
                              child: Text("<Consejo del día>",
                              style: Theme.of(context).textTheme.displayLarge,
                              overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: AspectRatio(aspectRatio:1,
                      child: Container(
                        decoration: panelDecoracion(),),),
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