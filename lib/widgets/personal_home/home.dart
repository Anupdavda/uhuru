
import 'package:flutter/material.dart';
import 'package:uhuru/widgets/personal_home/received_data.dart';
// import 'package:provider/provider.dart';
// import 'package:uhuru/providers/personal_home_list.dart';
//import 'package:uhuru/widgets/apartment_card.dart';
//import 'package:uhuru/widgets/personal_home/add_apartment.dart';



import './personal_apartment.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // final apartmentData = Provider.of<PersonalHomeList>(context);
    // final apartment = apartmentData.loadedPersonalApartment;

    
    return Messages();
    //return apartment.isEmpty ? AddHome() :  PersonalApartment();  //DisplayHome();
   //return AddHome();
  }
}

// class DisplayHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final apartmentData = Provider.of<PersonalHomeList>(context);
//     // final apartment = apartmentData.loadedPersonalApartment;
//     // return ListView.builder(
//     //   itemCount: apartment.length,
//     //   itemBuilder: (ctx, i) =>
//     //      ChangeNotifierProvider.value(
//     //       value: apartment[i],
//     //       child: ApartmentItem(),
//     //     ),

//     // );
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       elevation: 8,
//       margin: EdgeInsets.all(4),
//       child: GestureDetector(
//         onTap: () {
//           // Navigator.of(context).pushNamed(
//           //   ApartmentDetailScreen.routeName,
//           //   arguments: apartment.id,
//           //  );
//         },
//         child: Column(
//           children: <Widget>[
//             // ClipRRect(
//             //   borderRadius: BorderRadius.circular(10.0),
//             //   child: Image.network(
//             //     apartment.imageUrl,
//             //     height: 250,
//             //     width: double.infinity,
//             //     fit: BoxFit.cover,
//             //   ),
//             // ),

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

//                           // Text(
//                           //   apartment.price.toString().replaceAllMapped(
//                           //       new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                           //       (Match m) => '${m[1]},'),
//                           //   style: TextStyle(
//                           //     fontSize: 20,
//                           //     fontWeight: FontWeight.bold,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           // Text(apartment.bedroom.toString() +
//                           //     " bd | " +
//                           //     apartment.bathroom.toString() +
//                           //     " ba | " +
//                           //     apartment.area.toString() +
//                           //     " sq-ft"),
//                           //Text(apartment.description),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           // Consumer<Apartment>(
//                           //   builder: (ctx, product, _) => IconButton(
//                           //     icon: Icon(
//                           //       apartment.isFavorite
//                           //           ? Icons.bookmark
//                           //           : Icons.bookmark_border,
//                           //     ),
//                           //     color: Colors.redAccent,
//                           //     onPressed: () {
//                           //       apartment.toggleFavoriteStatus();
//                           //     },
//                           //   ),
//                           // ),
//                           SizedBox(
//                             width: 6,
//                           ),
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
//                       // Text(apartment.streetName +
//                       //     ", " +
//                       //     apartment.city +
//                       //     ", " +
//                       //     apartment.zipcode.toString()),
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

// class AddHome extends StatelessWidget {
//   const AddHome({
//     Key key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.fromLTRB(40, 0, 50, 0),
//           child: Text(
//             'Do you have a House/Apartment?',
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         SizedBox(
//           height: 7,
//         ),
//         Container(
//           margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
//           child: Text(
//             'Add your house/apartment to the listing for renting or selling.',
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.normal,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         RaisedButton(
//           elevation: 10,
//           child: Text(
//             'Add your House',
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Ubuntu-Bold',
//               fontSize: 20,
//             ),
//           ),
//           color: Colors.redAccent,
//           onPressed: () {
//             Navigator.of(context).pushNamed(AddApartment.routeName);
//           },
         
//         ),
//       ],
//     );
//   }
// }
