import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/apartment_list.dart';
import '../widgets/apartment_card.dart';

class SavedApartmentScreen extends StatelessWidget {
  final bool showFavs;

  SavedApartmentScreen(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final apartmentData = Provider.of<ApartmentList>(context);
    final savedApartment = showFavs ? apartmentData.favoriteItems : null;
    if (apartmentData.favoriteItems.isEmpty) {
      return Center(
        child: Text('You have not saved any listing yet.'),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: savedApartment.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: savedApartment[i],
          child: ApartmentItem(),
        ),
      );
    }
  }
}
