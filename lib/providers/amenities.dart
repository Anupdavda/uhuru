import 'package:flutter/material.dart';

class Amenity with ChangeNotifier {
  final String id;
  final String title;
  final IconData icon;
  bool isSelected;

  Amenity(
      {this.id,
      @required this.title,
      @required this.icon,
      this.isSelected = false});

  void toggleSelectedStatus() {
    isSelected = !isSelected;
    notifyListeners();
  }
}
