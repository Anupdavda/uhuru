import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterModel with ChangeNotifier {
  double minPrice;
  double maxPrice;
  List<String> bedroom;
  List<String> bathroom;
  String city;
  double zipcode;
  RangeValues area;
 Map<String, dynamic> amenities;

  FilterModel({
    @required this.minPrice,
    @required this.maxPrice,
    @required this.bedroom,
    @required this.bathroom,
    @required this.city,
    @required this.zipcode,
    @required this.area,
    @required this.amenities,
  });

  Map<String, dynamic> toMap() {
    return {
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'city': city,
      'zipcode': zipcode,
      'area': area,
      'amenities': amenities,
    };
  }
}
