import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/personal_apartment.dart';
import '../providers/personal_apartment_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> getApartment(PersonalHomeList personalApartmentList) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection('apartments').getDocuments();

  List<PersonalApartment> _loadedPersonalApartment = [];
  snapshot.documents.forEach((result) {
    PersonalApartment personalApartment =
        PersonalApartment.fromMap(result.data);
    _loadedPersonalApartment.add(personalApartment);
  });
  personalApartmentList.apartmentList = _loadedPersonalApartment;
}

 uploadApartment(PersonalApartment personalApartment, bool isUpdating,
    File imageFile, Function apartmentUploaded) async {
  final ref =
      FirebaseStorage.instance // adds reference to the storage in firebase
          .ref()
          .child('apartment_images')
          .child(Timestamp.now().toString() + '.jpg');
  await ref.putFile(imageFile).onComplete;

  String url = await ref.getDownloadURL();
  personalApartment.imageUrl = url;

  _uploadNewApartment(personalApartment, isUpdating, apartmentUploaded,
      imageUrl: url);
}

void _uploadNewApartment(PersonalApartment personalApartment, bool isUpdating,
    Function apartmentUploaded,
    {String imageUrl}) async {
  CollectionReference apartmentRef =
      Firestore.instance.collection('apartments');
  if (imageUrl != null) {
    personalApartment.imageUrl = imageUrl;
  }

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


uploadAmenities(PersonalApartment personalApartment) async{
   CollectionReference apartmentRef =
      Firestore.instance.collection('apartments');

    DocumentReference documentRef =
        await apartmentRef.add(personalApartment.toMap());

    personalApartment.id = documentRef.documentID;

    print('uploaded apartment successfully: ${personalApartment.toString()}');

    await documentRef.setData(personalApartment.toMap(), merge: true);
  
}

deleteApartments(PersonalApartment personalApartment, Function apartmentDeleted) async{
if(personalApartment.imageUrl != null){
  StorageReference storageReference =  await FirebaseStorage.instance.getReferenceFromUrl(personalApartment.imageUrl);
  await storageReference.delete();
  print('image deleted');
}
await Firestore.instance.collection('apartments').document(personalApartment.id).delete();
apartmentDeleted(personalApartment);
}