import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:uhuru/model/personal_apartment.dart';
//import 'package:uhuru/provider/filter_provider.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';

Query query = FirebaseFirestore.instance.collection('apartments');

_personalApartmentFromMap(
    QuerySnapshot snapshot, List _loadedPersonalApartment) {
  snapshot.docChanges.forEach((result) {
    PersonalApartment personalApartment = new PersonalApartment(
        id: result.doc['id'],
        userId: result.doc['userId'],
        amenities: result.doc['amenities'],
        area: result.doc['area'],
        bathroom: result.doc['bathroom'],
        bedroom: result.doc['bedroom'],
        city: result.doc['city'],
        createdAt: result.doc['createdAt'],
        description: result.doc['description'],
        imageUrl: result.doc['imageUrl'],
        price: result.doc['price'],
        streetName: result.doc['streetName'],
        updatedAt: result.doc['updatedAt'],
        zipcode: result.doc['zipcode']);
    _loadedPersonalApartment.add(personalApartment);
  });
}

Future<void> getApartmentbyFilter(
    PersonalHomeList personalApartmentList,
    String city,
    double maxPrice,
    double minPrice,
    RangeValues area,
    double zipcode,
    List bedroom,
    List bathroom) async {
  //if(bathroom.isNotEmpty)
}

// Future<void> getApartmentSimpleQuery(PersonalHomeList personalApartmentList,
//     String city, double maxPrice, double minPrice, RangeValues area, double zipCode){
//  if (city.isNotEmpty && city != "Any") {
//   query = query.where("city", isEqualTo: city);
// }
// if (zipCode != null && zipCode != "Any") {
//   query = query.where("zipCode", isEqualTo: zipCode);
// }
// if (minPrice != null || maxPrice != null) {
//   if (minPrice != null) {
//     query = query.where("price", ">=", minPrice);
//   }
//   if (maxPrice != null) {
//     query = query.where("price", "<=", maxPrice);
//   }
// } else if (minArea != null || maxArea != null) {
//   ...
// } else if (...) { ... }

// }

Future<void> getApartmentbyCityPrice(
    PersonalHomeList personalApartmentList,
    String city,
    double maxPrice,
    double minPrice,
    double zipcode,
    List bathroom,
    Map amenity) async {
  var _amenitiesKeys = amenity.keys.toList();
  var _amenitiesValues = amenity.values.toList();
  List _trueAmenitiesValues = [];
  List _trueAmenitiesKeys = [];

  for (int i = 0; i < _amenitiesValues.length; i++) {
    if (_amenitiesValues[i] == true) {
      _trueAmenitiesValues.add(_amenitiesValues[i]);
      _trueAmenitiesKeys.add(_amenitiesKeys[i]);
    }
  }
  // IGNORE: This method wont work
  QuerySnapshot snapshot =
      await query.where('amenities.Air Condition', isEqualTo: false).get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  personalApartmentList.apartmentListByCity = _loadedPersonalApartment;

  //   List<PersonalApartment> _loadedPersonalApartment = [];
  //   _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  //   personalApartmentList.apartmentListByCity = _loadedPersonalApartment;

  // if (city == "Any" && maxPrice != null && minPrice != null) {
  //   List<PersonalApartment> _loadedPersonalApartment = [];
  //   QuerySnapshot snapshot = await query
  //       .where("price",
  //           isGreaterThanOrEqualTo: minPrice, isLessThanOrEqualTo: maxPrice)
  //       .get();
  //   _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  //   personalApartmentList.apartmentListByCity = _loadedPersonalApartment;
  // } else if (city.isNotEmpty &&
  //     city != "Any" &&
  //     maxPrice == 0.0 &&
  //     minPrice == 0.0) {
  //   QuerySnapshot snapshot = await query.where("city", isEqualTo: city).get();
  //   List<PersonalApartment> _loadedPersonalApartment = [];
  //   _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  //   personalApartmentList.apartmentListByCity = _loadedPersonalApartment;
  // } else {
  //   QuerySnapshot snapshot = await query
  //       .where("city", isEqualTo: city)
  //       .where("price",
  //           isGreaterThanOrEqualTo: minPrice, isLessThanOrEqualTo: maxPrice)
  //       .get();
  //   List<PersonalApartment> _loadedPersonalApartment = [];
  //   _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  //   personalApartmentList.apartmentListByCity = _loadedPersonalApartment;
  // }
}

Future<void> getApartmentbyPrice(PersonalHomeList personalApartmentList,
    double minPrice, double maxPrice) async {
  QuerySnapshot snapshot = await query
      .where("price",
          isGreaterThanOrEqualTo: minPrice, isLessThanOrEqualTo: maxPrice)
      .get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);
  personalApartmentList.apartmentListByPrice = _loadedPersonalApartment;
}

Future<void> getApartmentbyArea(
    PersonalHomeList personalApartmentList, RangeValues areaRange) async {
  QuerySnapshot snapshot = await query
      .where("area",
          isGreaterThanOrEqualTo: areaRange.start,
          isLessThanOrEqualTo: areaRange.end)
      .get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  personalApartmentList.apartmentListByArea = _loadedPersonalApartment;
}

Future<void> getApartmentbyBedroom(
    PersonalHomeList personalApartmentList, List bedroom) async {
  QuerySnapshot snapshot =
      await query.where("bathroom", arrayContainsAny: bedroom).get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  personalApartmentList.apartmentListByBedroom = _loadedPersonalApartment;
}

Future<void> getApartmentbyBathroom(
    PersonalHomeList personalApartmentList, List bathroom) async {
  QuerySnapshot snapshot =
      await query.where("bathroom", arrayContainsAny: bathroom).get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  personalApartmentList.apartmentListByBathroom = _loadedPersonalApartment;
}

Future<void> getApartmentbyZipcode(
    PersonalHomeList personalApartmentList, String zipcode) async {
  QuerySnapshot snapshot =
      await query.where("zipcode", isEqualTo: zipcode).get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  personalApartmentList.apartmentListByZipCode = _loadedPersonalApartment;
}

Future<void> getApartmentbyAmenities(
    PersonalHomeList personalApartmentList, List<String> amenities) async {
  QuerySnapshot snapshot =
      await query.where("amenities", arrayContainsAny: amenities).get();
  List<PersonalApartment> _loadedPersonalApartment = [];
  _personalApartmentFromMap(snapshot, _loadedPersonalApartment);

  personalApartmentList.apartmentListByAmenity = _loadedPersonalApartment;
}

