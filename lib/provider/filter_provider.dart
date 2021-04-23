import 'package:flutter/material.dart';
import 'package:uhuru/model/filter_model.dart';

class FilterProvider with ChangeNotifier {
  FilterModel _filterItems;

  FilterModel get filterItems {
    return _filterItems;
  }

  void addProduct(FilterModel filter) {
    final filterApartment = FilterModel(
        amenities: filter.amenities,
        area: filter.area,
        bathroom: filter.bathroom,
        bedroom: filter.bedroom,
        city: filter.city,
        minPrice: filter.minPrice,
        maxPrice: filter.maxPrice,
        zipcode: filter.zipcode);
    _filterItems = filterApartment;

    notifyListeners();
  }
}
