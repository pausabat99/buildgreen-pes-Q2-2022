import 'package:buildgreen/services.dart/places_service.dart';
import 'package:buildgreen/widgets/places_search.dart';
import 'package:flutter/cupertino.dart';

class ApplicationBloc with ChangeNotifier {
  final placesService = PlacesService();

  List<PlacesSearch> searchResults = [];

  ApplicationBloc();

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
