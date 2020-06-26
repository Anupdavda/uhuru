// import 'package:flutter/material.dart';
// import '../providers/apartment_list.dart';
// import '../widgets/apartment_card.dart';
// import 'package:provider/provider.dart';

// class ApartmentListItem extends StatefulWidget {
//   @override
//   _ApartmentListItemState createState() => _ApartmentListItemState();
// }

// class _ApartmentListItemState extends State<ApartmentListItem> {
//   @override
//   Widget build(BuildContext context) {
//     final apartmentData = Provider.of<ApartmentList>(context);
//     final apartment = apartmentData.loadedApartment;
//     return ListView.builder(
//       itemCount: apartment.length,
//       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//         value: apartment[i],
//         child: ApartmentItem(),
//       ),
//     );
//   }
// }
