import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm({Key? key, 
    required this.controller,
    this.hintLabel,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintLabel;
  final bool obscureText;

  UnderlineInputBorder getBorder(){
    return const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context){
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: TextField(
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
          ),
        ),
      ),
    );
  }
}