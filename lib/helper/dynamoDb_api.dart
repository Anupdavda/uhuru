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

  // QuerySnapshot snapshot =
  //     await FirebaseFirestore.instance.collection('apartments').get();

  // snapshot.docChanges.forEach((result) {
  //   PersonalApartment personalApartment = new PersonalApartment(
  //     id: result.doc['id'],
  //     userId: result.doc['userId'],
  //     amenities: result.doc['amenities'],
  //     area: result.doc['area'],
  //     bathroom: result.doc['bathroom'],
  //     bedroom: result.doc['bedroom'],
  //     city: result.doc['city'],
  //     createdAt: result.doc['createdAt'],
  //     description: result.doc['description'],
  //     imageUrl: result.doc['imageUrl'],
  //     price: result.doc['price'],
  //     streetName: result.doc['streetName'],
  //     updatedAt: result.doc['updatedAt'],
  //     zipcode: result.doc['zipcode'],
  //   );
  //   _loadedPersonalApartment.add(personalApartment);
  // });
  // personalApartmentList.apartmentList = _loadedPersonalApartment;
}

// Future<void> getApartmentbyUserId(PersonalHomeList personalApartmentList) async {
//      var user = FirebaseAuth.instance.currentUser;
//   QuerySnapshot snapshot =
//       await FirebaseFirestore.instance.collection('apartments').where("userId", isEqualTo: user.uid).get();

//   List<PersonalApartment> _loadedPersonalApartment = [];
//   snapshot.docChanges.forEach((result) {
//     PersonalApartment personalApartment = new PersonalApartment(
//       id: result.doc['id'],
//       userId: result.doc['userId'],
//       amenities: result.doc['amenities'],
//       area: result.doc['area'],
//       bathroom: result.doc['bathroom'],
//       bedroom: result.doc['bedroom'],
//       city: result.doc['city'],
//       createdAt: result.doc['createdAt'],
//       description: result.doc['description'],
//       imageUrl: result.doc['imageUrl'],
//       price: result.doc['price'],
//       streetName: result.doc['streetName'],
//       updatedAt: result.doc['updatedAt'],
//       zipcode: result.doc['zipcode'],
//     );
//     _loadedPersonalApartment.add(personalApartment);
//   });
//   personalApartmentList.apartmentListByUserId = _loadedPersonalApartment;
// }

// uploadApartment(PersonalApartment personalApartment, bool isUpdating,
//     List<Asset> images, Function apartmentUploaded) async {
//   List<String> _imageUrlList;

//   for (var imageFile in images) {
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child('apartment_images')
//         .child(Timestamp.now().toString() + '.jpg');
//     UploadTask uploadTask =
//         ref.putData((await imageFile.getByteData()).buffer.asUint8List());
//     TaskSnapshot storageTaskSnapshot = await uploadTask;
//     String url = await storageTaskSnapshot.ref.getDownloadURL();
//     _imageUrlList.add(url);

//     personalApartment.imageUrl = _imageUrlList;

//     _uploadNewApartment(personalApartment, isUpdating, apartmentUploaded,
//         imageUrl: _imageUrlList);

//     return url;
//   }
// }

// _uploadNewApartment(PersonalApartment personalApartment, bool isUpdating,
//     Function apartmentUploaded,
//     {List imageUrl}) async {
//   CollectionReference apartmentRef =
//       FirebaseFirestore.instance.collection('apartments');

//   if (isUpdating) {
//     personalApartment.updatedAt = Timestamp.now();

//     await apartmentRef
//         .doc(personalApartment.id)
//         .update(personalApartment.toMap());

//     apartmentUploaded(personalApartment);
//     print('updated apartment with id: ${personalApartment.id}');
//   } else {
//     personalApartment.createdAt = Timestamp.now();

//     DocumentReference documentRef =
//         await apartmentRef.add(personalApartment.toMap());

//     personalApartment.id = documentRef.id;

//     print('uploaded apartment successfully: ${personalApartment.toString()}');

//     await documentRef.set(personalApartment.toMap(), SetOptions(merge: true));
//     apartmentUploaded(personalApartment);
//   }
// }

// deleteApartments(
//     PersonalApartment personalApartment, Function apartmentDeleted) async {
//   if (personalApartment.imageUrl.isNotEmpty) {
//     for (int i = 0; i < personalApartment.imageUrl.length; i++) {
//       String fileName =
//           personalApartment.imageUrl[i].replaceAll("%2F", "*");
//       fileName = fileName.replaceAll("%", "=");
//       fileName = fileName.replaceAll("?alt", "*");
//       fileName = fileName.replaceAll("=2C=20", ", ");
//       fileName = fileName.replaceAll("3D", "");
//       fileName = fileName.split("*")[1];

//       List<String> imageFiles = [];
//       imageFiles.add(fileName);
//         var user = FirebaseAuth.instance.currentUser;

//       for (int j = 0; j < imageFiles.length; j++) {
//         print('/'+ user.uid+ '/' + imageFiles[j]);

//         FirebaseFirestore.instance
//             .collection('apartments')
//             .doc(personalApartment.id)
//             .delete()
//             .then((value) => print('apartment deleted'));
//         apartmentDeleted(personalApartment);

//         Reference storageReference =
//             FirebaseStorage.instance.ref('/'+ user.uid+ '/' + imageFiles[j]);
//         await storageReference
//             .delete()
//             .then((value) => print('images deleted'));
//      }
//     }
//   } else {
//     FirebaseFirestore.instance
//         .collection('apartments')
//         .doc(personalApartment.id)
//         .delete()
//         .then((value) => print('apartment deleted'));
//     apartmentDeleted(personalApartment);
//   }
// }
