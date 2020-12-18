// import 'package:flutter/cupertino.dart';
// import '../model/apartment.dart';

// class ApartmentList with ChangeNotifier {
//   List<Apartment> _loadedApartment = [
//     Apartment(
//       id: 'p1',
//       bedroom: 5,
//       bathroom: 2,
//       area: 2000,
//       price: 220455.99,
//       streetName: '2709 Jeffersons Commons Dr',
//       city: 'Columbus',
//       zipcode: 47201,
//       imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/7/76/Vuojoen_kartano_8.jpg',
//       description:
//           'This is a well maintained house! Immaculate and updated in sought after Dormont. Gorgeous fully equiped kitchen with all appliances. Spacious living room with extra storage off back leading to dect overlooking fenced yard. Master bedroom offers beautiful attached built in with lots of closet space. Please Contact for more information and schedule a tour. ',
//     ),
//     Apartment(
//       id: 'p2',
//       price: 223459.99,
//       bedroom: 8,
//       bathroom: 3,
//       area: 200,
//       streetName: '2709 Jeffersons Commons Dr',
//       city: 'Columbus',
//       zipcode: 47201,
//       imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/a/aa/Attica_06-13_Zografou_02_Mansion.jpg',
//       description:
//           'This is a well maintained house! Immaculate and updated in sought after Dormont. Gorgeous fully equiped kitchen with all appliances. Spacious living room with extra storage off back leading to dect overlooking fenced yard. Master bedroom offers beautiful attached built in with lots of closet space. ',
//     ),
//     Apartment(
//       id: 'p3',
//       price: 579519.99,
//       bedroom: 7,
//       bathroom: 8,
//       area: 20000,
//       streetName: '2709 Jeffersons Commons Dr',
//       city: 'Columbus',
//       zipcode: 47201,
//       imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/4/4d/Hermagor_Untermoeschach_8_Biedermeierschloessl_Lerchenhof_01092016_4008.jpg',
//       description:
//           'This is a well maintained house! Immaculate and updated in sought after Dormont. Gorgeous fully equiped kitchen with all appliances. Spacious living room with extra storage off back leading to dect overlooking fenced yard. Master bedroom offers beautiful attached built in with lots of closet space. ',
//     ),
//     Apartment(
//       id: 'p4',
//       price: 203449.99,
//       bedroom: 5,
//       bathroom: 5,
//       area: 5000,
//       imageUrl:
//           'https://upload.wikimedia.org/wikipedia/commons/7/76/Vuojoen_kartano_8.jpg',
//       streetName: '2709 Jeffersons Commons Dr',
//       city: 'Columbus',
//       zipcode: 47201,
//       description:
//           'This is a well maintained house! Immaculate and updated in sought after Dormont. Gorgeous fully equiped kitchen with all appliances. Spacious living room with extra storage off back leading to dect overlooking fenced yard. Master bedroom offers beautiful attached built in with lots of closet space. ',
//     ),
//   ];

//   List<Apartment> get loadedApartment {
   
//     return [..._loadedApartment];
//   }

//   List<Apartment> get favoriteItems {
//     return _loadedApartment
//         .where((loadedApartment) => loadedApartment.isFavorite)
//         .toList();
//   }

  

//   Apartment findById(String id) {
//     return _loadedApartment
//         .firstWhere((loadedApartment) => loadedApartment.id == id);
//   }

//   void addApartment(Apartment apartment) {
//     final newApartment = Apartment(
//       price: apartment.price,
//       id: DateTime.now().toString(),
//       description: apartment.description,
//       imageUrl: apartment.imageUrl,
//       area: apartment.area,
//       bedroom: apartment.bedroom,
//       bathroom: apartment.bathroom,
//       zipcode: apartment.zipcode,
//       streetName: apartment.streetName,
//       city: apartment.city,
//     );
//     _loadedApartment.add(newApartment);

//     notifyListeners();
//   }

 

// }
