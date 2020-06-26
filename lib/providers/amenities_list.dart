import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './amenities.dart';

class AmenitiesList with ChangeNotifier {
  List<Amenity> _amenitiesList = [
    Amenity(id: "a1", title: 'Air Condition', icon: Icons.ac_unit),
    Amenity(id: "a2", title: 'Ceiling Fan', icon: Icons.ac_unit),
    Amenity(id: "a3", title: 'Ceramic Tiles', icon: Icons.directions_bike),
    Amenity(id: "a4", title: 'Carpet', icon: Icons.directions_boat),
    Amenity(id: "a5", title: 'Furnished', icon: Icons.directions_bus),
    Amenity(id: "a6", title: 'Closet', icon: Icons.directions_walk),
    Amenity(id: "a7", title: 'Elevator', icon: Icons.directions_car),
    Amenity(id: "a8", title: 'Laundry', icon: Icons.ac_unit),
    Amenity(id: "a9", title: 'Security', icon: Icons.security),
    Amenity(id: "a8", title: 'Parking', icon: Icons.local_parking),
    Amenity(id: "a9", title: 'Swimming Pool', icon: Icons.dvr),
    Amenity(id: "a10", title: 'Hardwood Floor', icon: Icons.copyright),
  ];

  var _selectedAmenitiesOnly = false;

  List<Amenity> get amenitiesList {
    return [..._amenitiesList];
  }

  List<Amenity> get selectedAmenities {
    if (_selectedAmenitiesOnly) {
      return _amenitiesList
          .where((amenitiesItem) => amenitiesItem.isSelected)
          .toList();
    }
    return [..._amenitiesList];
  }

  Amenity findById(String id) {
    return _amenitiesList.firstWhere((amenity) => amenity.id == id);
  }
}
