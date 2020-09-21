// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../model/personal_apartment.dart';

class PersonalHomeList with ChangeNotifier {
  List<PersonalApartment> _loadedPersonalApartment = [];
  PersonalApartment _currentApartment;

  List<PersonalApartment> get loadedPersonalApartment {
    return [..._loadedPersonalApartment];
  }

   PersonalApartment get currentApartment => _currentApartment;

  set apartmentList(List<PersonalApartment> personalApartment) {
    _loadedPersonalApartment = personalApartment;
    notifyListeners();
  }

  set currentApartment(PersonalApartment personalApartment) {
    _currentApartment = personalApartment;
    notifyListeners();
  }

  // Future<void> fetchAndSetApartment() async {
  //   try {
  //     QuerySnapshot snapshot =
  //         await Firestore.instance.collection('apartments').getDocuments();

  //     List<PersonalApartment> loadedPersonalApartments = [];
  //     snapshot.documents.forEach((result) {
  //       PersonalApartment personalApartment =
  //           PersonalApartment.fromMap(result.data);
  //       loadedPersonalApartments.add(personalApartment);
  //     });
  //     _loadedPersonalApartment = loadedPersonalApartments;
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  // Future<void> addApartments(
  //     PersonalApartment personalApartment, File imageFile) async {
  //   final ref =
  //       FirebaseStorage.instance // adds reference to the storage in firebase
  //           .ref()
  //           .child('apartment_images')
  //           .child(Timestamp.now().toString() + '.jpg');
  //   await ref.putFile(imageFile).onComplete;

  //   String url = await ref.getDownloadURL();
  //   personalApartment.imageUrl = url;

  //   CollectionReference apartmentRef =
  //       Firestore.instance.collection('apartments');
  //   personalApartment.createdAt = Timestamp.now();

  //   DocumentReference documentRef =
  //       await apartmentRef.add(personalApartment.toMap());

  //   personalApartment.id = documentRef.documentID;

  //   print('uploaded apartment successfully: ${personalApartment.toString()}');

  //   await documentRef.setData(personalApartment.toMap(), merge: true);
  //   _loadedPersonalApartment.add(personalApartment);
  //   notifyListeners();
  // }

  PersonalApartment findById(String id) {
    return _loadedPersonalApartment
        .firstWhere((loadedApartment) => loadedApartment.id == id);
  }

  // Future<void> updateApartment(
  //     String id, PersonalApartment personalApartment) async {
  //   final apartmentIndex = _loadedPersonalApartment
  //       .indexWhere((apartment) => apartment.id == apartment.id);
  //   _loadedPersonalApartment[apartmentIndex] = personalApartment;
  //   notifyListeners();
  // }

  void addApartment(PersonalApartment apartment) {
    _loadedPersonalApartment.add(apartment);

    notifyListeners();
  }

  // void deleteApartment(PersonalApartment personalApartment) {
  //   _loadedPersonalApartment
  //       .removeWhere((_apartment) => _apartment.id == personalApartment.id);
  //   notifyListeners();
  // }

  // Future<void> deleteApartments(
  //     String id, PersonalApartment personalApartment) async {
  //   var existingApartmentIndex =
  //       _loadedPersonalApartment.indexWhere((apartment) => apartment.id == id);

  //   _loadedPersonalApartment.removeAt(existingApartmentIndex);
  //    print('deleted Successfully from list');

  //   notifyListeners();
  //   // if (personalApartment.imageUrl != null) {
  //   //   StorageReference storageReference = await FirebaseStorage.instance
  //   //       .getReferenceFromUrl(personalApartment.imageUrl);
  //   //   await storageReference.delete();

  //   //   print('image deleted');
  //   // }
  //   await Firestore.instance
  //       .collection('apartments')
  //       .document(personalApartment.id)
  //       .delete();
  //       print('deleted Successfully in cloudstore');

  // }
}
