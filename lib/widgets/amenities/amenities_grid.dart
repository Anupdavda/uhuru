import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/providers/amenities_list.dart';


import './amenities_item.dart';

class AmenitiesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final amenitiesData = Provider.of<AmenitiesList>(context);
    final amenities = amenitiesData.amenitiesList;
    return GridView.builder(
      itemCount: amenities.length,
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: amenities[i], child: AmenitiesItem()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 1,
      ),
    );
  }
}
