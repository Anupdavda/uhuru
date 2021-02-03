import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
import 'package:uhuru/utils/constants.dart';
//import '../providers/apartment_list.dart';
import '../widgets/apartment_card.dart';

class SavedApartmentScreen extends StatelessWidget {
  final bool showFavs;

  const SavedApartmentScreen(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final apartmentData = Provider.of<PersonalHomeList>(context);
    final savedApartment = showFavs ? apartmentData.favoriteItems : null;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Saved Apartment',
            style: TextStyle(color: COLOR_INDIGO),
          ),
        ),
      ),
      body: apartmentData.favoriteItems.isEmpty
          ? Center(
              child: const Text('You have not saved any listing yet.',
                  style: TextStyle(
                    color: COLOR_BLACK,
                    fontSize: 16,
                  )),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: savedApartment.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: savedApartment[i],
                child: ApartmentCard(
                  savedApartment[i].id != savedApartment[i].id,
                ),
              ),
            ),
    );
  }
}
