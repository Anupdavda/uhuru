import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../model/personal_apartment.dart';
import '../provider/personal_apartment_list.dart';
import 'package:firebase_storage/firebase_storage.dart';

//import 'dart:io';

Future<void> getApartment(PersonalHomeList personalApartmentList) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('apartments').get();

  List<PersonalApartment> _loadedPersonalApartment = [];
  snapshot.docChanges.forEach((result) {
    PersonalApartment personalApartment = new PersonalApartment(
      id: result.doc['id'],
      amenities: result.doc['amenities'],
      area: result.doc['area'],
      bathroom: result.doc['bathroom'],
      bedroom: result.doc['bedroom'],
      city: result.doc['city'],
      createdAt: result.doc['createdAt'],
      description: result.doc['description'],
      imageUrl: result.doc['imageUrl'],
      price: result.doc['price'],
      streetName: result.doc['streetName'],
      updatedAt: result.doc['updatedAt'],
      zipcode: result.doc['zipcode'],
    );
    _loadedPersonalApartment.add(personalApartment);
  });
  personalApartmentList.apartmentList = _loadedPersonalApartment;
}

uploadApartment(PersonalApartment personalApartment, bool isUpdating,
    List<Asset> images, Function apartmentUploaded) async {
  List<String> _imageUrlList;

  for (var imageFile in images) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('apartment_images')
        .child(Timestamp.now().toString() + '.jpg');
    UploadTask uploadTask =
        ref.putData((await imageFile.getByteData()).buffer.asUint8List());
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String url = await storageTaskSnapshot.ref.getDownloadURL();
    _imageUrlList.add(url);

    personalApartment.imageUrl = _imageUrlList;

    _uploadNewApartment(personalApartment, isUpdating, apartmentUploaded,
        imageUrl: _imageUrlList);

    return url;
  }
}

_uploadNewApartment(PersonalApartment personalApartment, bool isUpdating,
    Function apartmentUploaded,
    {List imageUrl}) async {
  CollectionReference apartmentRef =
      FirebaseFirestore.instance.collection('apartments');

  if (isUpdating) {
    personalApartment.updatedAt = Timestamp.now();

    await apartmentRef
        .doc(personalApartment.id)
        .update(personalApartment.toMap());

    apartmentUploaded(personalApartment);
    print('updated apartment with id: ${personalApartment.id}');
  } else {
    personalApartment.createdAt = Timestamp.now();

    DocumentReference documentRef =
        await apartmentRef.add(personalApartment.toMap());

    personalApartment.id = documentRef.id;

    print('uploaded apartment successfully: ${personalApartment.toString()}');

    await documentRef.set(personalApartment.toMap(), SetOptions(merge: true));
    apartmentUploaded(personalApartment);
  }
}

deleteApartments(
    PersonalApartment personalApartment, Function apartmentDeleted) async {
  if (personalApartment.imageUrl != null) {
    for (int i = 0; i < personalApartment.imageUrl.length; i++) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('/apartment_images')
          .child(personalApartment.imageUrl[i]);

      await storageReference.delete();
    }
  } else {
    FirebaseFirestore.instance
        .collection('apartments')
        .doc(personalApartment.id)
        .delete();
    apartmentDeleted(personalApartment);
  }

  FirebaseFirestore.instance
      .collection('apartments')
      .doc(personalApartment.id)
      .delete();
  apartmentDeleted(personalApartment);
  print('images deleted');
}
