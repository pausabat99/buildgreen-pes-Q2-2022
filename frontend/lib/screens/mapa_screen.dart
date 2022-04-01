// ignore_for_file: import_of_legacy_library_into_null_safe


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final  _initialCameraPosition = CameraPosition(target: LatLng(41.4026556,2.1587003), zoom: 12);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10)),
            /// TITLE
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 50,
                top: 10,
              ),
              child: const Text(
                'Mapa',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            /// SEARCH BAR
            Container(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: filterController,
                decoration: const InputDecoration(
                  //border: OutlineInputBorder(),
                  hintText: 'Filtrar',
                  icon: Icon(Icons.search),
                ),
              )
            ),
            /// MAPS
            Expanded(
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                myLocationButtonEnabled: true,
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
