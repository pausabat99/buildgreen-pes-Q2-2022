import 'dart:async';

import 'package:buildgreen/services.dart/places_service.dart';
import 'package:buildgreen/widgets/places_search.dart';
import 'package:flutter/cupertino.dart';

import 'models/place.dart';

class ApplicationBloc with ChangeNotifier {
  final placesService = PlacesService();

  List<PlacesSearch> searchResults = [];
  Place selectedLocation = Place(
      name: "name",
      number: "number",
      postalCode: 'postalCode');

  ApplicationBloc();

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    //selectedLocation.add(await placesService.getPlace(placeId));
    selectedLocation = await placesService.getPlace(placeId);
    searchResults = []; //aixo ho buida, potser no funciona
    notifyListeners();
    //return (selectedLocation.name + ', ' + selectedLocation.number);
  }

  String getSelectedLocation() {
    return (selectedLocation.name + ', ' + selectedLocation.number);
  }

  String getSelectedLocationPCode() {
    return selectedLocation.postalCode;
  }

  /*@override
  void dispose() {
    //selectedLocation.close();
    super.dispose();
  }*/
}
