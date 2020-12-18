
import 'package:flutter/cupertino.dart';

import '../model/personal_apartment.dart';

class PersonalHomeList with ChangeNotifier {
  List<PersonalApartment> _loadedPersonalApartment = [];
  PersonalApartment _currentApartment;

  List<PersonalApartment> get loadedPersonalApartment {
    return [..._loadedPersonalApartment];
  }

   PersonalApartment get currentApartment => _currentApartment;

  set apartmentList(List<PersonalApartment> personalApartment) {
    _loadedPersonalApartment = personalApartment;
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


  

  // PersonalApartment findById(String id) {
  //   return _loadedPersonalApartment
  //       .firstWhere((loadedApartment) => loadedApartment.id == id);
  // }

 

  void addApartment(PersonalApartment apartment) {
    _loadedPersonalApartment.add(apartment);

    notifyListeners();
  }

 
}
