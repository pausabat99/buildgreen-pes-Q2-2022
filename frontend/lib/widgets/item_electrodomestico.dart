
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemElectrodomestico extends StatelessWidget {
 const ItemElectrodomestico({
   Key? key,
   required this.title,
 }) : super(key: key);

 final String title;

 @override
 Widget build(BuildContext context){
   return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(10),
                  child: Text(title),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
 }
}