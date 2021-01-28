import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
//import '../providers/apartment_list.dart';
import '../widgets/apartment_card.dart';

class SavedApartmentScreen extends StatelessWidget {
  final bool showFavs;

 const SavedApartmentScreen(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final apartmentData = Provider.of<PersonalHomeList>(context);
    final savedApartment = showFavs ? apartmentData.favoriteItems : null;
    if (apartmentData.favoriteItems.isEmpty) {
      return Center(
        child: const Text('You have not saved any listing yet.'),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: savedApartment.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: savedApartment[i],
          child: ApartmentCard(
             savedApartment[i].id !=  savedApartment[i].id ,
          ),
        ),
      );
    }
  }
}
