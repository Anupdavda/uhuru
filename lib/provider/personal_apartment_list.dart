import 'package:flutter/cupertino.dart';

import '../model/personal_apartment.dart';

class PersonalHomeList with ChangeNotifier {
  List<PersonalApartment> _loadedPersonalApartment = [];
  List<PersonalApartment> _loadedPersonalApartmentByUserId = [];
  // List<PersonalApartment> _loadedPersonalApartmentByCity = [];
  // List<PersonalApartment> _loadedPersonalApartmentByPrice = [];
  // List<PersonalApartment> _loadedPersonalApartmentByArea = [];
  // List<PersonalApartment> _loadedPersonalApartmentByBathroom = [];
  // List<PersonalApartment> _loadedPersonalApartmentByBedroom = [];
  // List<PersonalApartment> _loadedPersonalApartmentByZipcode = [];
  // List<PersonalApartment> _loadedPersonalApartmentByAmenity = [];
  PersonalApartment _currentApartment;

  List<PersonalApartment> get loadedPersonalApartment {
    return [..._loadedPersonalApartment];
  }

  List<PersonalApartment> get loadedPersonalApartmentByUserId {
    return [..._loadedPersonalApartmentByUserId];
  }
  
  //  List<PersonalApartment> get loadedPersonalApartmentByCity {
  //   return [..._loadedPersonalApartmentByCity];
  // }

  //  List<PersonalApartment> get loadedPersonalApartmentByPrice {
  //   return [..._loadedPersonalApartmentByPrice];
  // }

  //  List<PersonalApartment> get loadedPersonalApartmentByArea {
  //   return [..._loadedPersonalApartmentByArea];
  // }

  //  List<PersonalApartment> get loadedPersonalApartmentByBathroom {
  //   return [..._loadedPersonalApartmentByBathroom];
  // }

  //  List<PersonalApartment> get loadedPersonalApartmentByBedroom {
  //   return [..._loadedPersonalApartmentByBedroom];
  // }

  //  List<PersonalApartment> get loadedPersonalApartmentByZipcode {
  //   return [..._loadedPersonalApartmentByZipcode];
  // }

  //  List<PersonalApartment> get loadedPersonalApartmentByAmenity {
  //   return [..._loadedPersonalApartmentByAmenity];
  //}

  PersonalApartment get currentApartment => _currentApartment;

  set apartmentList(List<PersonalApartment> personalApartment) {
    _loadedPersonalApartment = personalApartment;
    notifyListeners();
  }

  set apartmentListByUserId(List<PersonalApartment> personalApartment) {
    _loadedPersonalApartmentByUserId = personalApartment;
    notifyListeners();
  }

  // set apartmentListByCity(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByCity = personalApartment;
  //   notifyListeners();
  // }
  // set apartmentListByPrice(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByPrice = personalApartment;
  //   notifyListeners();
  // }
  // set apartmentListByArea(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByArea = personalApartment;
  //   notifyListeners();
  // }
  // set apartmentListByBathroom(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByBathroom = personalApartment;
  //   notifyListeners();
  // }
  // set apartmentListByBedroom(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByBedroom = personalApartment;
  //   notifyListeners();
  // }

  //  set apartmentListByZipCode(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByZipcode = personalApartment;
  //   notifyListeners();
  // }

  // set apartmentListByAmenity(List<PersonalApartment> personalApartment) {
  //   _loadedPersonalApartmentByAmenity = personalApartment;
  //   notifyListeners();
  // }

  set currentApartment(PersonalApartment personalApartment) {
    _currentApartment = personalApartment;
    notifyListeners();
  }

  List<PersonalApartment> get favoriteItems {
    return _loadedPersonalApartment
        .where((loadedApartment) => loadedApartment.isFavorite)
        .toList();
  }

  deleteApartment(PersonalApartment personalApartment) {
    _loadedPersonalApartment.removeWhere(
        (_loadedApartment) => _loadedApartment.id == personalApartment.id);
    notifyListeners();
  }

  // PersonalApartment findById(String id) {
  //   return _loadedPersonalApartment
  //       .firstWhere((loadedApartment) => loadedApartment.id == id);
  // }

  void addApartment(PersonalApartment apartment) {
    _loadedPersonalApartment.add(apartment);

    notifyListeners();
  }
}
