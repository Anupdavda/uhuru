import 'package:flutter/material.dart';
import 'package:uhuru/utils/constants.dart';
import 'package:uhuru/widgets/amenities_filter_chips.dart';
import 'package:uhuru/widgets/room_bathroom_chips.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var selectedPriceRange = RangeValues(1, 100);
  var selectedAreaRange = RangeValues(2000, 23651);
  RangeLabels priceLabels = RangeLabels('1', "100");
  RangeLabels areaLabels = RangeLabels('2000', "23651");

  @override
  Widget build(BuildContext context) {
    Widget sliderOption(
        RangeValues selectedRange, RangeLabels labels, double min, double max) {
      return RangeSlider(
        divisions: 1,
        values: selectedRange,
        labels: labels,
        onChanged: (RangeValues newRange) {
          print("START: ${selectedRange.start}, End: ${selectedRange.end}");
          setState(() {
            selectedRange = newRange;
            labels = RangeLabels("${selectedRange.start.toInt().toString()}\$",
                "${selectedRange.start.toInt().toString()}\$");
          });
        },
        min: min,
        max: max,
        activeColor: Colors.blue[900],
        inactiveColor: Colors.grey[300],
      );
    }

    // Widget buildOption(String text) {
    //   return Container(
    //     height: 45,
    //     width: 60,
    //     decoration: BoxDecoration(
    //         color: selected ? Colors.blue[900] : Colors.transparent,
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(5),
    //         ),
    //         border: Border.all(
    //           width: selected ? 0 : 1,
    //           color: Colors.grey,
    //         )),
    //     child: Center(
    //       child: Text(
    //         text,
    //         style: TextStyle(
    //           color: selected ? Colors.white : Colors.black,
    //           fontSize: 14,
    //         ),
    //       ),
    //     ),
    //   );
    // }

    Widget _cityTextFormField() {
      return TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),

        onFieldSubmitted: (_) {},
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Please enter a city.';
        //   }
        //   if (value.length > 1 && value.length < 5) {
        //     return 'Should be at least 5 characters long.';
        //   }
        //   return null;
        // },
        onSaved: (value) {
          // value;
        },
      );
    }

    Widget _zipcodeTextFormField() {
      return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Zip Code/P.O.Box',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        textInputAction: TextInputAction.next,
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return 'Please enter valid Zipcode/P.O.Box.';
        //   }
        //   if (double.tryParse(value) == null) {
        //     return 'Please enter valid Zipcode/P.O.Box.';
        //   }
        //   if (double.parse(value) <= 0) {
        //     return 'Please enter a number greater than zero.';
        //   }
        //   return null;
        // },
        onSaved: (value) {
          //   _currentApartment.zipcode = double.parse(value);
        },
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 32, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price range", style: TEXT_THEME_DEFAULT.headline1),
            sliderOption(selectedPriceRange, priceLabels, 1, 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${selectedPriceRange.start.toInt().toString()}",
                    style: TEXT_THEME_DEFAULT.headline4),
                Text("\$${selectedPriceRange.end}",
                    style: TEXT_THEME_DEFAULT.headline4),
              ],
            ),
            const SizedBox(height: 16),
            Text("Area", style: TEXT_THEME_DEFAULT.headline1),
            sliderOption(selectedAreaRange, areaLabels, 2000, 23651),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${selectedAreaRange.start.toInt().toString()}\ sq-ft",
                    style: TEXT_THEME_DEFAULT.headline4),
                Text("${selectedAreaRange.end}\ sq-ft",
                    style: TEXT_THEME_DEFAULT.headline4),
              ],
            ),
            const SizedBox(height: 16),
            Text("Rooms", style: TEXT_THEME_DEFAULT.headline1),
            const SizedBox(height: 16),
            RoomBathroomChips(),
            const SizedBox(height: 16),
            Text("Bathrooms", style: TEXT_THEME_DEFAULT.headline1),
            const SizedBox(height: 16),
            RoomBathroomChips(),
            const SizedBox(height: 16),
            Text("City", style: TEXT_THEME_DEFAULT.headline1),
            const SizedBox(height: 16),
            _cityTextFormField(),
            const SizedBox(height: 16),
            Text("Zip Code/P.O.BOX", style: TEXT_THEME_DEFAULT.headline1),
            const SizedBox(height: 16),
            _zipcodeTextFormField(),
            const SizedBox(height: 16),
            Text("Amenities", style: TEXT_THEME_DEFAULT.headline1),
            const SizedBox(height: 16),
            AmenitieFilterChips(),
            const SizedBox(height: 16),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: const Text('Apply Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                    primary: COLOR_GREENACCENT[400],
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
