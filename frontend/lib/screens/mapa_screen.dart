// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:buildgreen/screens/request_permission/request_permission_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final _lController = RequestPermissionController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.4026556, 2.1587003),
    zoom: 14.4746,
  );

  final Set<Heatmap> _heatmaps = {};

  final LatLng _heatmapLocation = const LatLng(37.42796133580664, -122.085749655962);

  TextEditingController filterController = TextEditingController();
  

  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _lController.request();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addHeatmap,
        label: const Text('Add Heatmap'),
        icon: const Icon(Icons.add_box),
      ),
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
                padding: const EdgeInsets.all(10),
                
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
                    initialCameraPosition: _kGooglePlex,
                    heatmaps: _heatmaps,
                    compassEnabled: true,
                    mapType: MapType.normal,
                    buildingsEnabled: true,
                    mapToolbarEnabled: true,
                    cameraTargetBounds: CameraTargetBounds.unbounded,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addHeatmap(){
    setState(() {
      _heatmaps.add(
        Heatmap(
          heatmapId: HeatmapId(_heatmapLocation.toString()),
          points: _createPoints(_heatmapLocation),
          radius: 20,
          visible: true,
          gradient:  HeatmapGradient(
            colors: const <Color>[Colors.green, Colors.red], startPoints: const <double>[0.2, 0.8]
          )
        )
      );
    });
  }

  List<WeightedLatLng> _createPoints(LatLng location) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    //Can create multiple points here
    points.add(_createWeightedLatLng(location.latitude,location.longitude, 0));
    points.add(_createWeightedLatLng(location.latitude-1,location.longitude, 1)); 
    return points;
  }

  WeightedLatLng _createWeightedLatLng(double lat, double lng, int weight) {
    return WeightedLatLng(point: LatLng(lat, lng), intensity: weight);
  }
}
