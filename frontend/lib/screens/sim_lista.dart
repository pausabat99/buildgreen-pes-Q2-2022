import 'package:flutter/material.dart';
class SimuladorList extends StatefulWidget {
  const SimuladorList({ Key? key }) : super(key: key);

  @override
  State<SimuladorList> createState() => _SimuladorListState();
}

class _SimuladorListState extends State<SimuladorList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}