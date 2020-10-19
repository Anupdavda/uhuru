import 'package:flutter/material.dart';

class Amenity with ChangeNotifier {
  final String  name;
  final IconData icon;
  bool isSelected;

  Amenity({
    @required this.name,
    @required this.icon,
    this.isSelected = false,
  });

 
}
