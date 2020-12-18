import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:uhuru/model/amenities.dart';

class PersonalApartment with ChangeNotifier {
  String id;
  String description;
  double price;
  List imageUrl = [];
  String streetName;
  int bedroom;
  double bathroom;
  String city;
  double zipcode;
  double area;
  List amenities = [];
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isFavorite;

  PersonalApartment(
      {this.id,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      @required this.streetName,
      @required this.bedroom,
      @required this.bathroom,
      @required this.city,
      @required this.zipcode,
      @required this.area,
      @required this.amenities,
       this.createdAt,
       this.updatedAt,
      this.isFavorite = false});

  // Map _amenities = {
  //   'air_condition': Icon(Icons.ac_unit),
  //   'ceiling_fan': Icon(Icons.ac_unit),
  //   'ceramic_tiles': Icon(Icons.flag),
  //   'carpet': Icon(Icons.satellite),
  //   'furnished': Icon(Icons.radio),
  //   'closed': Icon(Icons.accessibility),
  //   'elevator': Icon(Icons.equalizer),
  //   'laundry': Icon(Icons.train),
  //   'security': Icon(Icons.security),
  //   'parking': Icon(Icons.local_parking),
  //   'swimmingPool': Icon(Icons.swap_horiz),
  //   'hardwoodFloor': Icon(Icons.security),
  // };

  // PersonalApartment.fromMap(Map<String, dynamic> data) {
  //   id = data['id'];
  //   description = data['description'];
  //   price = data['price'];
  //   imageUrl = data['imageUrl'];
  //   streetName = data['streetName'];
  //   bedroom = data['bedroom'];
  //   bathroom = data['bathroom'];
  //   city = data['city'];
  //   zipcode = data['zipcode'];
  //   area = data['area'];
  //   amenities = data['amenities'];
  //   createdAt = data['createdAt'];
  //   updatedAt = data['updatedAt'];
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'streetName': streetName,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'city': city,
      'zipcode': zipcode,
      'area': area,
      'amenities': amenities,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
