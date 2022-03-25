
import 'package:buildgreen/screens/area_personal_cliente.dart';
import 'package:buildgreen/widgets/general_buttom.dart';
import 'package:flutter/material.dart';

class ListaPropiedades extends StatefulWidget {
  const ListaPropiedades({Key? key}) : super(key: key);

  @override
  State<ListaPropiedades> createState() => _ListaPropiedades();
}

//Classe Item Propiedad
class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
  });

  String headerValue;
  bool isExpanded;
}

//Generar propiedades para la Expansion Panel List
List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(headerValue: 'Calle Falsa 123'
        //expandedValue: 'This is item number $index',
        );
  });
}

class _ListaPropiedades extends State<ListaPropiedades> {
  //Se rellena  la lista de propiedades
  late final List<Item> _data = generateItems(1);

  TextEditingController nameController = TextEditingController();

  void newPropiety() {
    setState(() {
      int lastItemIndex = _data.length;
      Item nitem = Item(headerValue: 'Nueva Propiedad');
      _data.insert(lastItemIndex, nitem);
    });
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: const Image(
                image: AssetImage("assets/images/propiedadadminverde.png"),
                height: 100,
                width: 100,
              ),
              title: Text(item.headerValue),
            );
          },
          body: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                  title: const Text("Abrir Propiedad"),
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AreaPersonalCliente()));
                    });
                  }),
              ListTile(
                title: const Text("Eliminar Propiedad"),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('¡ATENCIÓN!'),
                    content: const Text('¿Quieres borrar esta propiedad?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancelar'),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _data.removeWhere(
                                (Item currentItem) => item == currentItem);
                          });
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            Column(children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 50,
                ),
                child: const Text(
                  'Propiedades',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 50,
                  bottom: 50,
                ),
                child: const Text(
                  'Cartera de propiedades',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                child: _buildPanel(),
              ),
              
              GeneralButton(title: "Añadir propiedad", textColor: Colors.white, action: newPropiety)
            ]),
          ],
        ),
    );
  }
}
