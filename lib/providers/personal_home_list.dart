import 'package:flutter/cupertino.dart';

import './apartment.dart';

class PersonalHomeList with ChangeNotifier {
  List<Apartment> _loadedPersonalApartment = [];

  List<Apartment> get loadedPersonalApartment {
    return [..._loadedPersonalApartment];
  }

  Apartment findById(String id) {
    return _loadedPersonalApartment.firstWhere(
        (_loadedPersonalApartment) => _loadedPersonalApartment.id == id);
  }

  void addApartment(Apartment apartment) {
    final newApartment = Apartment(
      price: apartment.price,
      area: apartment.area,
      bathroom: apartment.bathroom,
      bedroom: apartment.bedroom,
      streetName: apartment.streetName,
      city: apartment.city,
      zipcode: apartment.zipcode,
      id: DateTime.now().toString(),
      imageUrl: apartment.imageUrl,
      description: apartment.description,
    );
    _loadedPersonalApartment.add(newApartment);
    notifyListeners();
  }

  void removeListing(String id) {
    _loadedPersonalApartment.remove(id);
    notifyListeners();
  }
}
