import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget{
  const GeneralButton({Key? key, 
    required this.title,
    required this.textColor,
    required this.action,
  }) : super(key: key);

  final String title;
  final Color textColor;
  final Function() action;

  @override 
  Widget build(BuildContext context){
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          primary: Colors.teal.withAlpha(0),
          onPrimary: Colors.white.withAlpha(0),
          shadowColor: Colors.black.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: BorderSide(
            color: textColor,
            width: 3,
          ),
          elevation: 1
        ),
        onPressed: action,
        child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textColor,),),
      ),
    );
  }
}