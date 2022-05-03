// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';

import 'package:buildgreen/screens/request_permission/request_permission_controller.dart';
import 'package:buildgreen/widgets/expandable_action_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_heatmap/google_maps_flutter_heatmap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// ignore: library_prefixes
import 'package:buildgreen/constants.dart' as Constants;
import 'package:buildgreen/classes/place_model.dart';


class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}



class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final _lController = RequestPermissionController();

  List<Marker> allMarkers = [];


  static const CameraPosition _kBarcelona = CameraPosition(
    target: LatLng(41.4026556, 2.1587003),
    zoom: 15,
    bearing: 45,
    tilt: 45,
  );

  final Set<Heatmap> _heatmaps = {};

  TextEditingController filterController = TextEditingController();
  
  Future<void> getHeatMap(String endpoint) async{
    EasyLoading.show(status: 'Loading map...');
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
      final emissions = result["emissions_de_co2"];
      locations.add(LatLng(latitude, longitude));
      weights.add(double.parse(emissions).round());
    }
    debugPrint("alg");
    setState(() {
      _heatmaps.add(
        Heatmap(
          heatmapId: HeatmapId(_heatmapLocation.toString()),
          points: _createPointsList(locations, weights),
          radius: 50,
          visible: true,
          gradient:  HeatmapGradient(
            colors: const <Color>[Colors.green, Colors.red], startPoints: const <double>[0.1, 1]
          )
        )
      );
      
    });
    
    EasyLoading.dismiss();    
  }


  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    for (var element in placeList) {
      allMarkers.add(
        Marker(
          markerId: MarkerId(element.placeName),
          draggable: false,
          infoWindow: InfoWindow(
            title: element.placeName,
            snippet: element.placeAddress
          ),
          position: element.locationCords
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    _lController.request();
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
              onPressed: () => {},
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
              onPressed: () => {},
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
              onPressed: () => {},
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
                    boxShadow: [
              
                      BoxShadow(color: Colors.black26, offset: Offset(3, 3), blurRadius: 5)
                    ]
                  ),
                  
                  
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
