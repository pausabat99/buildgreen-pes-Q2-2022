// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';

import 'package:buildgreen/screens/request_permission/request_permission_controller.dart';
import 'package:buildgreen/service_subscriber.dart';
import 'package:buildgreen/services.dart/places_service.dart';
import 'package:buildgreen/widgets/expandable_action_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// ignore: library_prefixes
import 'package:buildgreen/constants.dart' as Constants;
import 'package:buildgreen/models/place.dart';

List<Marker> markersFromPlaces(List<Place> places) {
  List<Marker> markers = [];
  for (Place place in places) {
    markers.add(Marker(
      markerId: MarkerId(place.name),
      position: LatLng(place.latitude, place.longitude),
      infoWindow: InfoWindow(
        title: place.name,
        snippet: place.number,
      ),
    ));
  }
  return markers;
}

class MapaScreen extends StatefulWidget {
  static const route = "/mapa";
  final String isAdmin;
  
  const MapaScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}
class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final _lController = RequestPermissionController();

  List<Place> allMarkers = [];
  List<Marker> allMarkersReal = [];// = markersFromPlaces(allMarkers);

  _MapaScreenState(){
      generateItems('/properties/').then((val) => setState(() {
          allMarkers = val;
        },
      ),
    );
  }

  static const CameraPosition _kBarcelona = CameraPosition(
    target: LatLng(41.4026556, 2.1587003),
    zoom: 17,
    tilt: 45,
  );

  final Set<Heatmap> _heatmaps = {};

  TextEditingController filterController = TextEditingController();
  
  Future<void> getHeatMap(String endpoint) async{
    EasyLoading.show(status: 'Loading map...', maskType: EasyLoadingMaskType.clear);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.get(
        Uri.parse(Constants.API_ROUTE+endpoint),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: "Token " + prefs.getString("_user_token"),
        },
    );

    List<LatLng> locations = [];
    List<int> weights = [];

    final responseJson = jsonDecode(response.body);
    for (var result in responseJson){
      final latitude = double.parse(result['latitud']);
      final longitude = double.parse(result['longitud']);
      final emissions = result["value"];
      locations.add(LatLng(latitude, longitude));
      weights.add(double.parse(emissions).round());
    }

    setState(() {
      _heatmaps.clear();
      _heatmaps.add(
        Heatmap(
          heatmapId: HeatmapId("0"),
          points: _createPointsList(locations, weights),
          radius: 50,
          visible: true,
          gradient:  HeatmapGradient(
            colors: const <Color>[Colors.green, Colors.red], startPoints: const <double>[0.1, 1]
          )
        )
      );
    },
  );
    EasyLoading.dismiss();    
  }

  Future<List<Place>> generateItems(String endpoint) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(Constants.API_ROUTE + endpoint),
    headers: <String, String>{
      HttpHeaders.authorizationHeader:
          "Token " + prefs.getString("_user_token"),
    },
  );

  final responseJson = jsonDecode(response.body);
  List<Place> resultado = [];
  for (var current in responseJson) {
    final String route = current['address'] + current['apt'] + ',' +current['postal_code'];
    Place result =  await PlacesService().getPlaceByName(route);
    resultado.add(result);
  }
  return resultado;
  } //end generateItems
 
  @override
  Widget build(BuildContext context) {
    _lController.request();
    late final markers = generateItems('/properties/');
    return Scaffold(
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          Container(
            decoration:  const ShapeDecoration(
              color: Colors.orangeAccent,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(3, 3),
                  blurRadius: 5
                )
              ]
            ),
            child: IconButton(
              onPressed: (){setState(() {
                _heatmaps.clear();
              });},
              icon: const Icon(Icons.location_off_rounded),
              color: Colors.white,
              
            ),
          ),
          Container(
            decoration:  const ShapeDecoration(
              color: Colors.lightBlueAccent,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(3, 3),
                  blurRadius: 5
                )
              ]
            ),
            child: IconButton(
              onPressed: (){getHeatMap('/qualificationMap');},
              icon: const Icon(Icons.power),
              color: Colors.white,
            ),
          ),
          Container(
            decoration:  const ShapeDecoration(
              color: Colors.green,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(3, 3),
                  blurRadius: 5
                )
              ]
            ),
            child: IconButton(
              onPressed: (){getHeatMap('/co2map');},
              iconSize: 40,
              icon: const Icon(Icons.co2),
              color: Colors.white,
            ),
          ),
        ],
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, offset: Offset(3, 3), blurRadius: 5)
                    ]
                  ),
                  
                  
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(20),
                    child: GoogleMap(
                      initialCameraPosition: _kBarcelona,
                      heatmaps: _heatmaps,
                      compassEnabled: true,
                      rotateGesturesEnabled: false,
                      mapType: MapType.hybrid,
                      buildingsEnabled: true,
                      mapToolbarEnabled: true,
                      cameraTargetBounds: CameraTargetBounds.unbounded,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      markers: markersFromPlaces(allMarkers).toSet(),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<WeightedLatLng> _createPointsList(List<LatLng> locationList, List<int> wheights) {
    final List<WeightedLatLng> points = <WeightedLatLng>[];
    var index = 0;
    while (index < locationList.length){
      final location = locationList[index];
      final wheight = wheights[index];
      points.add(WeightedLatLng(point: location, intensity: wheight) );
      index += 1;
    }
    return points;
  }
}
