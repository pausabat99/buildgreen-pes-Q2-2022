// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:buildgreen/screens/request_permission/request_permission_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final _lController = RequestPermissionController(Permission.locationAlways);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.4026556, 2.1587003),
    zoom: 14.4746,
  );
  TextEditingController filterController = TextEditingController();
  

  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _lController.request();
    final _initialCameraPosition =  CameraPosition(target: LatLng(41.4026556,2.1587003), zoom: 12);
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
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                compassEnabled: true,
                mapType: MapType.hybrid,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
