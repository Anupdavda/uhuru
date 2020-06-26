// import 'package:flutter/material.dart';

// class AmenitiesList extends StatefulWidget {
//   @override
//   _AmenitiesListState createState() => _AmenitiesListState();
// }

// class _AmenitiesListState extends State<AmenitiesList> {
//   int selectedRadio;

//   @override
//   void initState() {
//     super.initState();
//     selectedRadio = 0;
//   }

//   setSelectedRadio(int val) {
//     setState(() {
//       selectedRadio = val;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Radio(
//                   value: 1,
//                   groupValue: selectedRadio,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                   },
//                 ),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.ac_unit, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Air Condition')),
//                 SizedBox(width: 20.0),
//                 Radio(
//                     value: 2,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       setSelectedRadio(val);
//                     }),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.directions_boat, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Ceramic Tiles')),
//               ]),
//           Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Radio(
//                   value: 3,
//                   groupValue: selectedRadio,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                   },
//                 ),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.cake, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Carpet')),
//                 SizedBox(width: 20.0),
//                 Radio(
//                     value: 4,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       setSelectedRadio(val);
//                     }),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.local_parking, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('parking')),
//               ]),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Radio(
//                 value: 5,
//                 groupValue: selectedRadio,
//                 onChanged: (val) {
//                   setSelectedRadio(val);
//                 },
//               ),
//               SizedBox(width: 1.0),
//               Icon(Icons.security, size: 20.0),
//               SizedBox(width: 10.0),
//               Expanded(child: Text('Security')),
//               SizedBox(width: 20.0),
//               Radio(
//                   value: 6,
//                   groupValue: selectedRadio,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                   }),
//               SizedBox(width: 1.0),
//               Icon(Icons.directions_boat, size: 20.0),
//               SizedBox(width: 10.0),
//               Expanded(child: Text('Furnished')),
//             ],
//           ),
//           Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Radio(
//                   value: 7,
//                   groupValue: selectedRadio,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                   },
//                 ),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.ac_unit, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Elevator')),
//                 SizedBox(width: 20.0),
//                 Radio(
//                     value: 8,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       setSelectedRadio(val);
//                     }),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.directions_boat, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Closet')),
//               ]),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Radio(
//                 value: 9,
//                 groupValue: selectedRadio,
//                 onChanged: (val) {
//                   setSelectedRadio(val);
//                 },
//               ),
//               SizedBox(width: 1.0),
//               Icon(Icons.ac_unit, size: 20.0),
//               SizedBox(width: 10.0),
//               Expanded(child: Text('Ceiling Fan')),
//               SizedBox(width: 20.0),
//               Radio(
//                   value: 10,
//                   groupValue: selectedRadio,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                   }),
//               SizedBox(width: 1.0),
//               Icon(Icons.golf_course, size: 20.0),
//               SizedBox(width: 10.0),
//               Expanded(child: Text('Laundry')),
//             ],
//           ),
//           Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Radio(
//                   value: 11,
//                   groupValue: selectedRadio,
//                   onChanged: (val) {
//                     setSelectedRadio(val);
//                   },
//                 ),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.ac_unit, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Hardwood Floor')),
//                 SizedBox(width: 20.0),
//                 Radio(
//                     value: 12,
//                     groupValue: selectedRadio,
//                     onChanged: (val) {
//                       setSelectedRadio(val);
//                     }),
//                 SizedBox(width: 1.0),
//                 Icon(Icons.directions_boat, size: 20.0),
//                 SizedBox(width: 10.0),
//                 Expanded(child: Text('Swimming Pool')),
//               ]),
//         ],
//       ),
//     );
//   }
// }
