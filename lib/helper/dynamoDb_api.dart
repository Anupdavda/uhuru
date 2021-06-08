// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
import '../model/personal_apartment.dart';
import '../provider/personal_apartment_list.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> getApartmentFromDynamoDB(
    PersonalHomeList personalApartmentList) async {
  var url = Uri.parse(
      'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos');

  List<PersonalApartment> _loadedPersonalApartment = [];

  return http.get(url).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      final temp = json.decode(response.body);
      for (var item in temp) {
        PersonalApartment personalApartment = PersonalApartment.fromJson(item);
        _loadedPersonalApartment.add(personalApartment);
      }
      print(_loadedPersonalApartment.toString());
      personalApartmentList.apartmentList = _loadedPersonalApartment;
      return _loadedPersonalApartment;
    }
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return null;
  });
}

deleteApartmentsDynamoDb(
    PersonalApartment personalApartment, Function apartmentDeleted) async {
  var url = Uri.parse(
      'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos/delete');

  http
      .delete(url,
          body: jsonEncode(<String, dynamic>{'id': personalApartment.id}))
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Success to DynamoDB');
      apartmentDeleted(personalApartment);
      return;
    } else {
      throw new Exception("Error while fetching data");
    }
  });
}
