// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:buildgreen/screens/request_permission/request_permission_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  TextEditingController filterController = TextEditingController();
  final _controller = RequestPermissionController(Permission.locationAlways);

  @override
  void initState(){
    super.initState();
    _controller.request();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _controller.request();
    const _initialCameraPosition =  CameraPosition(target: LatLng(41.4026556,2.1587003), zoom: 12);
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
              child: Text(
                AppLocalizations.of(context)!.mapa,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),

            /// MAPS
            Expanded(              
              child: Container(
                padding: const EdgeInsets.all(20),
                
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: const GoogleMap(
                    initialCameraPosition: _initialCameraPosition,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
