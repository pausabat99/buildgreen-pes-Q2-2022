import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemElectrodomesticoBorrable extends StatelessWidget {
  const ItemElectrodomesticoBorrable({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10, left: 50, right: 50),
      height: 80.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Text(title),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('¡ATENCIÓN!'),
                    content: const Text('¿Quieres borrar este electrodoméstico?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancelar'),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                icon: const Icon(Icons.delete)),
          ),
        ],
      ),
    );
  }
}
