import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm({Key? key, 
    required this.controller,
    this.hintLabel,
    this.obscureText = false,
    this.textColor,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintLabel;
  final bool obscureText;
  final Color? textColor;

  UnderlineInputBorder getBorder(){
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: textColor?? Colors.white,
        width: 3,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context){
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(5,),
        child: TextField(
          maxLength: 50,
          obscureText: obscureText,
          controller: controller,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            focusedBorder: getBorder(),
            enabledBorder: getBorder(),
            labelText: hintLabel,
            labelStyle: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
            counterText: ""
          ),
        ),
      ),
    );
  }
}