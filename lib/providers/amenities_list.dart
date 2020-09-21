// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../model/amenities.dart';

// class AmenitiesList with ChangeNotifier {
//   List<Amenity> _amenitiesList = [
 
//   ];


//   List<Amenity> get amenitiesList {
//     return [..._amenitiesList];
//   }

//   List<Amenity> get selectedAmenities {
//     if (_selectedAmenitiesOnly) {
//       return _amenitiesList
//           .where((amenitiesItem) => amenitiesItem.isSelected)
//           .toList();
//     }
//     return [..._amenitiesList];
//   }

//   Amenity findById(String id) {
//     return _amenitiesList.firstWhere((amenity) => amenity.id == id);
//   }
// }
