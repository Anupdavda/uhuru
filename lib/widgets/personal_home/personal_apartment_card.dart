// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:uhuru/model/apartment.dart';
// import 'package:uhuru/screens/personal_detail_screen.dart';

// //import '../../model/apartment.dart';


// class PersonalApartmentCard extends StatelessWidget {
//   final String id;
//   final double price;
//   final double area;
//   final int bedroom;
//   final double bathroom;
//   final String streetName;
//   final String city;
//   final double zipcode;
//   final String description;
//   final String image;
//   //final Key key;

//   PersonalApartmentCard(this.id, this.price, this.area, this.bedroom,
//       this.bathroom, this.streetName, this.city, this.zipcode, this.description,this.image);

//   @override
//   Widget build(BuildContext context) {
//    // final apartment = Provider.of<PersonalApartment>(context,listen: false);
    
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 8,
//       margin: EdgeInsets.all(4),
//       child: GestureDetector(
//         onTap: () {
          
//            Navigator.of(context).pushNamed(
//             PersonalDetailScreen.routeName,
//             arguments:id,);
//         },
//         child: Column(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: Image.network(
//                image,
//                 height: 250,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Icon(
//                             Icons.monetization_on,
//                           ),
//                           SizedBox(
//                             width: 6,
//                           ),
//                           Text(
//                             price.toString().replaceAllMapped(
//                                 new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                                 (Match m) => '${m[1]},'),
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(bedroom.toString() +
//                               " bd | " +
//                               bathroom.toString() +
//                               " ba | " +
//                              area.toString() +
//                               " sq-ft"),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Icon(
//                         Icons.location_city,
//                       ),
//                       SizedBox(
//                         width: 6,
//                       ),
//                       Text(
//                         streetName + ", " + city + ", " + zipcode.toString()),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
