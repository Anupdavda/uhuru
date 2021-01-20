import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../model/personal_apartment.dart';
import '../provider/personal_apartment_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'dart:io';

Future<void> getApartment(PersonalHomeList personalApartmentList) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('apartments').getDocuments();

  List<PersonalApartment> _loadedPersonalApartment = [];
  snapshot.documents.forEach((result) {
    PersonalApartment personalApartment = new PersonalApartment(
      id: result.data['id'],
      amenities: result.data['amenities'],
      area: result.data['area'],
      bathroom: result.data['bathroom'],
      bedroom: result.data['bedroom'],
      city: result.data['city'],
      createdAt: result.data['createdAt'],
      description: result.data['description'],
      imageUrl: result.data['imageUrl'],
      price: result.data['price'],
      streetName: result.data['streetName'],
      updatedAt: result.data['updatedAt'],
      zipcode: result.data['zipcode'],
    );
    _loadedPersonalApartment.add(personalApartment);
  });
  personalApartmentList.apartmentList = _loadedPersonalApartment;
}

uploadApartment(PersonalApartment personalApartment, bool isUpdating,
    List<Asset> images, Function apartmentUploaded) async {
  List<String> _imageUrlList;

  // final ref =
  //     FirebaseStorage.instance // adds reference to the storage in firebase
  //         .ref()
  //         .child('apartment_images')
  //         .child(Timestamp.now().toString() + '.jpg');
  // await ref.putFile(imageFile).onComplete;

  // String url = await ref.getDownloadURL();
  // _imageUrlList.add(url);
  // personalApartment.imageUrl = _imageUrlList;

  // _uploadNewApartment(personalApartment, isUpdating, apartmentUploaded,
  //     imageUrl: url);

  for (var imageFile in images) {
    final ref = FirebaseStorage.instance
        .ref()
        .child('apartment_images')
        .child(Timestamp.now().toString() + '.jpg');
    StorageUploadTask uploadTask =
        ref.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
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
      Firestore.instance.collection('apartments');

  if (isUpdating) {
    personalApartment.updatedAt = Timestamp.now();

    await apartmentRef
        .document(personalApartment.id)
        .updateData(personalApartment.toMap());

    apartmentUploaded(personalApartment);
    print('updated apartment with id: ${personalApartment.id}');
  } else {
    personalApartment.createdAt = Timestamp.now();

    DocumentReference documentRef =
        await apartmentRef.add(personalApartment.toMap());

    personalApartment.id = documentRef.documentID;

    print('uploaded apartment successfully: ${personalApartment.toString()}');

    await documentRef.setData(personalApartment.toMap(), merge: true);
    apartmentUploaded(personalApartment);
  }
}

deleteApartments(
    PersonalApartment personalApartment, Function apartmentDeleted) async {
  if (personalApartment.imageUrl != null) {
    for (int i = 0; i < personalApartment.imageUrl.length; i++) {
      StorageReference storageReference = await FirebaseStorage.instance
          .getReferenceFromUrl(personalApartment.imageUrl[i]);
      await storageReference.delete();
    }
  } else {
    Firestore.instance
        .collection('apartments')
        .document(personalApartment.id)
        .delete();
    apartmentDeleted(personalApartment);
  }

  Firestore.instance
      .collection('apartments')
      .document(personalApartment.id)
      .delete();
  apartmentDeleted(personalApartment);
  print('images deleted');
}
