
import 'package:buildgreen/screens/area_personal_cliente.dart';
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

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AreaPersonalCliente()));
  }

  void addItemToList() {
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
                image: AssetImage("images/propiedadadminverde.png"),
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
        body: Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.lightGreen,
            ],
          )),
        ),
        ListView(
          children: [
            Expanded(
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                        ),
                        child: Text(
                          'ÁREA PERSONAL',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 50,
                            top: 10,
                          ),
                          child: Image(
                            image: AssetImage("images/admin.png"),
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                        left: 50,
                        bottom: 50,
                      ),
                      child: Text(
                        'Cartera de propiedades',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: _buildPanel(),
                      ),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 50,
                          ), // use Spacer
                        ),
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Nueva propiedad',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: TextButton.styleFrom(
                              primary: const Color.fromARGB(255, 3, 68, 28)),
                          onPressed: () {
                            newPropiety();
                          },
                        ),
                      ),
                    ]),
              ]),
            ),
          ],
        ),
      ],
    ));
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
