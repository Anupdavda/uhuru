import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/model/filter_model.dart';
import 'package:flutter/services.dart';
import 'package:uhuru/provider/filter_provider.dart';
import 'package:uhuru/utils/constants.dart';
import 'package:uhuru/utils/custom_functions.dart';
// import 'package:uhuru/widgets/amenities_filter_chips.dart';
// import 'package:uhuru/widgets/bathroom_chips.dart';
// import 'package:uhuru/widgets/bedroom_chips.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  RangeValues selectedPriceRange = RangeValues(10000, 20000000);
  RangeValues selectedAreaRange = RangeValues(500, 20000);
  RangeLabels priceLabels = RangeLabels("100000", "10000000 +");
  RangeLabels areaLabels = RangeLabels("500", "20000 +");

  Map<String, dynamic> _amenities = {
    'Air condition': false,
    'Ceiling Fan': false,
    'Ceramic Tiles': false,
    'Carpet': false,
    'Furnished': false,
    'Closet': false,
    'Elevator': false,
    'Laundry': false,
    'Security': false,
    'Parking': false,
    'Swimming Pool': false,
    'Hardwood Floor': false,
  };

  // List<String> _amenitiesOptions = [
  //   'Air condition',
  //   'Ceiling Fan',
  //   'Ceramic Tiles',
  //   'Carpet',
  //   'Furnished',
  //   'Closet',
  //   'Elevator',
  //   'Laundry',
  //   'Security',
  //   'Parking',
  //   'Swimming Pool',
  //   'Hardwood Floor'
  // ];
  // List<bool> _selectedAmenities = [
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false,
  //   false
  // ];

 // List<String> _filterAmenities = <String>[];

  List<String> _bathroomOptions = ['Any', '1', '2', '3', '4', '5+'];
  List<bool> _selectedBathroom = [false, false, false, false, false, false];
  List<String> _filterBathroom = <String>[];

  List<String> _bedroomOptions = ['Any', '1', '2', '3', '4', '5+'];
  List<bool> _selectedBedroom = [false, false, false, false, false, false];
  List<String> _filterBedroom = <String>[];

  final _form = GlobalKey<FormState>();
  final clearText = TextEditingController();
  FilterModel _currentFilter;

  @override
  void initState() {
    super.initState();
    FilterProvider filterProvider =
        Provider.of<FilterProvider>(context, listen: false);
    if (filterProvider.filterItems != null) {
      _currentFilter = filterProvider.filterItems;
    } else {
      _currentFilter = FilterModel(
        minPrice: 0,
        maxPrice: 0,
        city: 'Any',
        area: RangeValues(500, 2000),
        amenities: _amenities,
        bathroom: [],
        bedroom: [],
        zipcode: 0,
      );
    }
  }
  
  Iterable<Widget> get _amenity sync* {
     yield* _amenities.keys.map((String key) {
          return FilterChip(
            selected: _amenities[key],
            label: Text(key),
            labelStyle: TextStyle(
              color: _amenities[key] ? Colors.white : Colors.black,
              fontSize: 18.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            side: BorderSide(
              color: Colors.grey,
              width: _amenities[key] ? 0 : 1,
            ),
            backgroundColor: Colors.transparent,
            selectedColor: Colors.blue[900],
            onSelected: (bool value) {
              _amenities[key] = value;
              setState(() {
                if (value) {
               _amenities[key] = value;
                  _amenities.update(key, (value) => value);
                } else {
                  _currentFilter.amenities[key] = value;
                  _currentFilter.amenities.update(key, (value) => value);
                }
              });
              
            },
            
          );
        }).toList();

  }


  // Iterable<Widget> get amenityWidgets sync* {
  //   for (int i = 0; i < _amenitiesOptions.length; i++) {
  //     yield FilterChip(
  //       selected: _selectedAmenities[i],
  //       label: Text(_amenitiesOptions[i]),
  //       labelStyle: TextStyle(
  //         color: _selectedAmenities[i] ? Colors.white : Colors.black,
  //         fontSize: 18.0,
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(50.0),
  //       ),
  //       side: BorderSide(
  //         color: Colors.grey,
  //         width: _selectedAmenities[i] ? 0 : 1,
  //       ),
  //       backgroundColor: Colors.transparent,
  //       selectedColor: Colors.blue[900],
  //       onSelected: (bool selected) {
  //         setState(() {
  //           _selectedAmenities[i] = selected;
  //           if (selected) {
  //             _filterAmenities.add(_amenitiesOptions[i]);
  //           } else {
  //             _filterAmenities.removeWhere((String name) {
  //               return name == _amenitiesOptions[i];
  //             });
  //           }
  //         });
  //         _currentFilter.amenities = _filterAmenities;
  //       },
  //     );
  //   }
  // }

  Iterable<Widget> get bathroomWidgets sync* {
    for (int i = 0; i < _bathroomOptions.length; i++) {
      yield FilterChip(
        selected: _selectedBathroom[i],
        label: Text(_bathroomOptions[i]),
        labelStyle: TextStyle(
          color: _selectedBathroom[i] ? Colors.white : Colors.black,
          fontSize: 18.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        side: BorderSide(
          color: Colors.grey,
          width: _selectedBathroom[i] ? 0 : 1,
        ),
        backgroundColor: Colors.transparent,
        selectedColor: Colors.blue[900],
        onSelected: (bool selected) {
          setState(() {
            _selectedBathroom[i] = selected;
            if (_selectedBathroom[i]) {
              _filterBathroom.add(_bathroomOptions[i]);
            } else {
              _filterBathroom.removeWhere((String name) {
                return name == _bathroomOptions[i];
              });
            }
          });
          _currentFilter.bathroom = _filterBathroom;
        },
      );
    }
  }

  Iterable<Widget> get bedroomWidgets sync* {
    for (int i = 0; i < _bedroomOptions.length; i++) {
      yield FilterChip(
        selected: _selectedBedroom[i],
        label: Text(_bedroomOptions[i]),
        labelStyle: TextStyle(
          color: _selectedBedroom[i] ? Colors.white : Colors.black,
          fontSize: 18.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        side: BorderSide(
          color: Colors.grey,
          width: _selectedBedroom[i] ? 0 : 1,
        ),
        backgroundColor: Colors.transparent,
        selectedColor: Colors.blue[900],
        onSelected: (bool selected) {
          setState(() {
            _selectedBedroom[i] = selected;
            if (_selectedBedroom[i]) {
              _filterBedroom.add(_bedroomOptions[i]);
            } else {
              _filterBedroom.removeWhere((String name) {
                return name == _bedroomOptions[i];
              });
            }
          });
          _currentFilter.bedroom = _filterBedroom;
        },
      );
    }
  }

  Widget _minPriceTextFormField() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          initialValue: _currentFilter.minPrice.toString(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'min',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          validator: (value) {
            if (double.parse(value) < 0.0) {
              return 'Please enter a number greater than zero.';
            }
            if (value.isEmpty) {
              return null;
            }
            return null;
          },
          onSaved: (value) {
            _currentFilter.minPrice = double.parse(value);
          },
        ),
      ),
    );
  }

  Widget _maxPriceTextFormField() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TextFormField(
          initialValue: _currentFilter.maxPrice.toString(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'max',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          validator: (value) {
            if (double.parse(value) < 0) {
              return 'Please enter a number greater than zero.';
            }
            if (value.isEmpty) {
              return null;
            }
            return null;
          },
          onSaved: (value) {
            _currentFilter.maxPrice = double.parse(value);
          },
        ),
      ),
    );
  }

  Widget _cityTextFormField() {
    return TextFormField(
        initialValue: _currentFilter.city,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onFieldSubmitted: (_) {},
        validator: (value) {
          if (value.length > 1 && value.length < 3) {
            return 'Should be at least 5 characters long.';
          }
          if (value.isEmpty) {
            return 'Add a city';
          }
          return null;
        },
        onSaved: (value) {
          _currentFilter.city = value;
        });
  }

  Widget _zipcodeTextFormField() {
    return TextFormField(
      initialValue: _currentFilter.zipcode.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Zip Code/P.O.Box',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (double.parse(value) < 0) {
          return 'Please enter a number greater than zero.';
        }
        if (value.isEmpty) {
          return null;
        }
        return null;
      },
      onSaved: (value) {
        _currentFilter.zipcode = double.parse(value);
      },
    );
  }

  Widget priceSliderOption() {
    return RangeSlider(
      divisions: selectedPriceRange.start <= 1000000 ||
              selectedPriceRange.end <= 1000000
          ? 100
          : 800,
      values: selectedPriceRange,
      labels: priceLabels,
      onChanged: (newRange) {
        print(
            "START: ${compactCurrency(newRange.start.toInt())}, End: ${compactCurrency(newRange.end.toInt())}");

        setState(() {
          selectedPriceRange = newRange;
          priceLabels = RangeLabels(
              "${compactCurrency(newRange.start.toInt())}",
              "${compactCurrency(newRange.end.toInt())}");
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
      divisions:
          selectedAreaRange.end.toInt() - selectedAreaRange.start.toInt(),
      values: selectedAreaRange,
      labels: areaLabels,
      onChanged: (newRange) {
        print("START: ${newRange.start}, End: ${newRange.end}");
        setState(() {
          selectedAreaRange = newRange;

          areaLabels = RangeLabels(
              "${compactCurrency(selectedAreaRange.start.toInt())}\ sq-ft",
              "${compactCurrency(selectedAreaRange.end.toInt())}\ sq-ft");

          _currentFilter.area =
              RangeValues(selectedAreaRange.start, selectedAreaRange.end);
        });
      },
      min: 500,
      max: 20000,
      activeColor: Colors.blue[900],
      inactiveColor: Colors.grey[300],
    );
  }

  _filterUpload(FilterModel filterModel) {
    FilterProvider filterProvider =
        Provider.of<FilterProvider>(context, listen: false);
    filterProvider.addProduct(filterModel);
  }

  Future<void> _saveForm() async {
    print('filter saved called');
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();

      _filterUpload(_currentFilter);

      debugPrint('city: ' + _currentFilter.city);
       debugPrint('amenities: ' + _currentFilter.amenities.toString());
      debugPrint('minPrice: ' + _currentFilter.minPrice.toString());
      debugPrint('maxPrice: ' + _currentFilter.maxPrice.toString());
      debugPrint('zip: ' + _currentFilter.zipcode.toString());
      debugPrint('area: ' + _currentFilter.area.toString());
      debugPrint('bathroom: ' + _currentFilter.bathroom.toString());
      debugPrint('bedroom: ' + _currentFilter.bedroom.toString());
      debugPrint('amenities: ' + _currentFilter.amenities.toString());
      debugPrint('bedroom: ' + _currentFilter.bedroom.toString());
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => Filter(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text('Apply Filter'),
          actions: [
            TextButton(
                child: Text('RESET', style: TextStyle(color: Colors.white)),
                onPressed: _reset)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(right: 10, left: 10, top: 32, bottom: 14),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price range", style: TEXT_THEME_DEFAULT.headline1),
                priceSliderOption(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "\$${compactCurrency(selectedPriceRange.start.toInt())}",
                        style: TEXT_THEME_DEFAULT.headline4),
                    Text("\$${compactCurrency(selectedPriceRange.end.toInt())}",
                        style: TEXT_THEME_DEFAULT.headline4),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _minPriceTextFormField(),
                    const SizedBox(width: 16),
                    Text('____'),
                    const SizedBox(width: 16),
                    _maxPriceTextFormField(),
                  ],
                ),
                const SizedBox(height: 16),
                Text("Area", style: TEXT_THEME_DEFAULT.headline1),
                areaSliderOption(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${compactCurrency(selectedAreaRange.start.toInt())}\ sq-ft",
                        style: TEXT_THEME_DEFAULT.headline4),
                    Text(
                        "${compactCurrency(selectedAreaRange.end.toInt())}\ sq-ft",
                        style: TEXT_THEME_DEFAULT.headline4),
                  ],
                ),
                const SizedBox(height: 16),
                Text("Rooms", style: TEXT_THEME_DEFAULT.headline1),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Wrap(
                            spacing: 25.0,
                            runSpacing: 3.0,
                            children: bathroomWidgets.toList())),
                  ),
                ),
                const SizedBox(height: 16),
                Text("Bathrooms", style: TEXT_THEME_DEFAULT.headline1),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Wrap(
                            spacing: 25.0,
                            runSpacing: 3.0,
                            children: bedroomWidgets.toList())),
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Wrap(
                            spacing: 5.0,
                            runSpacing: 3.0,
                            children: _amenity.toList())),
                  ),
                ),
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
                        primary: COLOR_BLUEACCENT[900],
                      ),
                      onPressed: () {
                        _saveForm();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
