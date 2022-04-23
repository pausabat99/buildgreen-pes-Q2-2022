import 'package:buildgreen/widgets/places_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buildgreen/widgets/places_search.dart';


class PlacesService {

  final  kGoogleApiKey = "AIzaSyCLFW_y78tJfYic8xMrzTxGbZVxnVgyCBs";


  Future<List<PlacesSearch>> getAutocomplete(String search) async {
    /*var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json" + 
              "?input=$search" + 
              "&location=41.4026556%2C2.1587003" + 
              "&radius=500" + 
              "&types=address" + 
              "&key=$kGoogleApiKey";
              */
    var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&strictbounds=true&location=41.3879,2.16992&radius=8000&types=address&language=es&key=$kGoogleApiKey";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var jsonResult = json['predictions'] as List;
    debugPrint(jsonResult.toString());

    return jsonResult.map((place) => PlacesSearch.fromJson(place)).toList();
  }
}
