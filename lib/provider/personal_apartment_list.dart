import 'package:flutter/cupertino.dart';

import '../model/personal_apartment.dart';

class PersonalHomeList with ChangeNotifier {
  List<PersonalApartment> _loadedPersonalApartment = [];
  List<PersonalApartment> _loadedPersonalApartmentByUserId = [];
  PersonalApartment _currentApartment;

  List<PersonalApartment> get loadedPersonalApartment {
    return [..._loadedPersonalApartment];
  }

  List<PersonalApartment> get loadedPersonalApartmentByUserId {
    return [..._loadedPersonalApartmentByUserId];
  }

  PersonalApartment get currentApartment => _currentApartment;

  set apartmentList(List<PersonalApartment> personalApartment) {
    _loadedPersonalApartment = personalApartment;
    notifyListeners();
  }

  set apartmentListByUserId(List<PersonalApartment> personalApartment) {
    _loadedPersonalApartmentByUserId = personalApartment;
    notifyListeners();
  }


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
