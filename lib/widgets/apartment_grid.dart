import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/apartment_card.dart';
import '../providers/apartment_list.dart';

class ApartmentGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apartmentData = Provider.of<ApartmentList>(context);
    final apartment = apartmentData.loadedApartment;
    //  final productId =
    //     ModalRoute.of(context).settings.arguments as String; // is the id!
    //  final loadedApartments = Provider.of<ApartmentList>(
    //   context,
    //   listen: false,
    // ).findById(productId);
    return ListView.builder(
      itemCount: apartment.length,
      itemBuilder: (ctx, i) =>  ChangeNotifierProvider.value(
          value: apartment[i],
          child: ApartmentItem(
           
          ),
        ),
      
    );
  }
}
