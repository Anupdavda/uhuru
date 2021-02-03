import 'package:flutter/material.dart';
import 'package:uhuru/utils/constants.dart';
import 'package:uhuru/widgets/amenities_filter_chips.dart';
import 'package:uhuru/widgets/room_bathroom_chips.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues selectedPriceRange = RangeValues(10000, 20000000);
  RangeValues selectedAreaRange = RangeValues(500, 20000);
  RangeLabels priceLabels = RangeLabels("10000", "20000000");
  RangeLabels areaLabels = RangeLabels("500", "20000");

  @override
  Widget build(BuildContext context) {
    Widget priceSliderOption() {
      return RangeSlider(
        divisions: 5,
        values: selectedPriceRange,
        labels: priceLabels,
        onChanged: (newRange) {
          print(
              "START: ${selectedPriceRange.start}, End: ${selectedPriceRange.end}");
          setState(() {
            selectedPriceRange = newRange;
            priceLabels = RangeLabels('${newRange.start.toInt().toString()}\$',
                '${newRange.end.toInt().toString()}\$');
          });
        },
        min: 10000,
        max: 20000000,
        activeColor: Colors.blue[900],
        inactiveColor: Colors.grey[300],
      );
    }

    Widget areaSliderOption() {
      return RangeSlider(
          divisions: 20,
        values: selectedAreaRange,
        labels: areaLabels,
        onChanged: (newRange) {
          print("START: ${newRange.start}, End: ${newRange.end}");
          setState(() {
            selectedAreaRange = newRange;
            areaLabels = RangeLabels(
                "${selectedAreaRange.start.toInt().toString()}\ sq-ft",
                "${selectedAreaRange.end.toInt().toString()}\ sq-ft");
          });
        },
        min: 500,
        max: 20000,
        activeColor: Colors.blue[900],
        inactiveColor: Colors.grey[300],
      );
    }

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
            priceSliderOption(),
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
            areaSliderOption(),
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
