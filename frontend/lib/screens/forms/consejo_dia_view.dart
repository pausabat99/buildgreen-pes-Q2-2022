import 'package:buildgreen/screens/arguments/advice_detail_argument.dart';
import 'package:buildgreen/screens/classes/advice.dart';
import 'package:buildgreen/widgets/general_background.dart';
import 'package:flutter/material.dart';
import 'package:buildgreen/screens/appliance_compare_screen.dart';
import 'package:flutter_html/flutter_html.dart';

class ConsejoDetalle extends StatefulWidget {

  static const route = '/advice_detail';

  const ConsejoDetalle({ Key? key }) : super(key: key);

  @override
  State<ConsejoDetalle> createState() => _ConsejoDetalleState();
}

class _ConsejoDetalleState extends State<ConsejoDetalle> {
  int value = 0;

  BorderRadius bRadius(String position, double radius){
    if (position == "left"){
      return BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius)
      );
    }

    else if (position == "right"){
      return BorderRadius.only(
        topRight: Radius.circular(radius),
        bottomRight: Radius.circular(radius)
      );
    }

    else if (position == "middle"){
      return BorderRadius.zero;
    }

    return BorderRadius.circular(radius);

  }

  // ignore: non_constant_identifier_names
  Widget CustomRadioButton(String text, int index, String position) {
    return Expanded(
      child: OutlinedButton(

        onPressed: () {
          setState(() {
            value = index;
          });
        },
        child: Text(
          text,
          style: const TextStyle(
            color:Colors.black,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            (value == index) ? Colors.green : Colors.white10),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: bRadius(position, 10))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AdviceDetailArgument;
    Advice advice = args.advice;

    return Scaffold(
      body: Stack(
        children: [
          const GeneralBackground(),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: panelDecoracion(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment:  CrossAxisAlignment.stretch,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  iconSize: 40,
                                  onPressed: ()=>Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back_rounded),
                                  color: Colors.white,
                                ),
                                
                                Expanded(
                                  child: Text(advice.title,
                                    style: Theme.of(context).textTheme.displayLarge,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                    
                    // IMAGE
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Container(
                          decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3,3,),
                                    blurRadius: 5.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/consejito.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // HTML
                    Expanded(
                      flex: 100,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SingleChildScrollView(
                            child: Html(
                              data: advice.description,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // NEXT TIME 
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        children: <Widget>[
                          CustomRadioButton("1 day", 1, "left"),
                          CustomRadioButton("1 week", 2, "middle"),
                          CustomRadioButton("2 weeks", 3, "middle"),
                          CustomRadioButton("Never", 4, "right")
                        ],
                      ),
                    ),
                    
                    // Buy buttom
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("COMPLETAR RETO:"+ advice.xps.toString() +"xp"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                        ),
                      ),
                    ),
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