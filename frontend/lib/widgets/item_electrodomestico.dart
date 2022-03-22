
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
   return Container(
                padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                    left: 50,
                    right: 50),
                child: Container(
                  height: 80.0,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: Text(title),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
 }
}