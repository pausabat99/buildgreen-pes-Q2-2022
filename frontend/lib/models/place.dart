class Place {
  String name;
  String number;
  String postalCode;

  Place({required this.name, required this.number, required this.postalCode});

  factory Place.fromJSON(Map<String, dynamic> parsedJson) {
    String numberAddress = "";
    String nameAddress = "";
    String pCode = "";

    List<dynamic> addressComponents = parsedJson['address_components'];

    for (var i = 0; i < addressComponents.length; i++) {
      for (var j = 0; j < addressComponents[i]['types'].length; j++) {
        if (addressComponents[i]['types'][j] == "postal_code") {
          pCode = addressComponents[i]['long_name'];
        }
        else if (addressComponents[i]['types'][j] == "street_number") {
          numberAddress = addressComponents[i]['long_name'];
        }
        else if (addressComponents[i]['types'][j] == "route") {
          nameAddress = addressComponents[i]['long_name'];
        }
      }
    }

    return Place(name: nameAddress, number: numberAddress, postalCode: pCode);
  }
}
