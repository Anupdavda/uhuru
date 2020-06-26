import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/providers/amenities.dart';

class AmenitiesItem extends StatefulWidget {
  @override
  _AmenitiesItemState createState() => _AmenitiesItemState();
}

class _AmenitiesItemState extends State<AmenitiesItem> {
 // bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final amenity = Provider.of<Amenity>(context, listen: false);
    // final personalAmenity =
    //     Provider.of<PersonalAmenities>(context, listen: false);

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Checkbox(
          //     value: isChecked,
          //     onChanged: (bool value) {
          //       setState(() {
          //         isChecked = value;
          //       //   if(isChecked == true){
          //       //      //personalAmenity.addItem(amenity.id, amenity.icon, amenity.title);
          //       //  print(amenity.title + " added to amenities list");
          //       //   }else{
          //       //     print(amenity.title + " removed from amenities list");
          //       //   }
          //       });
          //     }),
          Icon(amenity.icon, size: 20),
          SizedBox(width: 10),
          Expanded(child: Text(amenity.title)),   
        ]);
  }
}
