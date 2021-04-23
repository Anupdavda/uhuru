import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:uhuru/model/amenities.dart';

class PersonalApartment with ChangeNotifier {
  String id;
  String userId;
  String description;
  double price;
  List imageUrl = [];
  String streetName;
  int bedroom;
  double bathroom;
  String city;
  double zipcode;
  double area;
  Map<String, dynamic> amenities;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isFavorite;

  PersonalApartment(
      {this.id,
      this.userId,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
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

  factory PersonalApartment.fromJson(Map<String, dynamic> json) {
    return PersonalApartment(
      description: json['description'].toString(),
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      streetName: json['streetName'],
      bedroom: json['bedroom'],
      bathroom: json['bathroom'].toDouble(),
      city: json['city'],
      zipcode: json['zipcode'].toDouble(),
      area:  json['zipcode'].toDouble(),
      amenities:  json['amebities'],
    );
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
