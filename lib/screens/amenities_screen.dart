import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
import 'package:uhuru/screens/add_images.dart';

class AmenitiesScreen extends StatefulWidget {
  static const routeName = '/amenities-screen';

  final PersonalApartment personalApartment;
  final bool isUpdating;

 const AmenitiesScreen(this.personalApartment, {@required this.isUpdating});

  @override
  _AmenitiesScreenState createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
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

  PersonalApartment _currentApartment;

  @override
  void initState() {
    super.initState();
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    if (personalHomeList.currentApartment != null && widget.isUpdating) {
      _currentApartment = personalHomeList.currentApartment;
    } else {
      _currentApartment = PersonalApartment(
        id: '',
        amenities: _amenities,
        area: widget.personalApartment.area,
        bathroom: widget.personalApartment.bathroom,
        bedroom: widget.personalApartment.bedroom,
        city: widget.personalApartment.city,
        description: widget.personalApartment.description,
        imageUrl: [],
        price: widget.personalApartment.price,
        streetName: widget.personalApartment.streetName,
        zipcode: widget.personalApartment.zipcode,
      );
    }
  }

  Widget _amenitiesCheckBoxList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        shrinkWrap: false,
        children: _currentApartment.amenities.keys.map((String key) {
          return CheckboxListTile(
            title:  Text(key),
            value: widget.isUpdating
                ? _currentApartment.amenities[key]
                : _amenities[key],
            onChanged: (bool value) {
              setState(() {
                if (value && !widget.isUpdating) {
                  _amenities[key] = value;
                  _amenities.update(key, (value) => value);
                  debugPrint(_amenities['parking'].toString());
                  debugPrint(_amenities.keys.toString());
                  debugPrint(_amenities.values.toString());
                } else {
                  _currentApartment.amenities[key] = value;
                  _currentApartment.amenities.update(key, (value) => value);
                  debugPrint(_currentApartment.amenities.keys.toString());
                  debugPrint(_currentApartment.amenities.values.toString());
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  _saveAmenities() {
    _currentApartment = widget.personalApartment;
    _currentApartment.amenities =
        widget.isUpdating ? _currentApartment.amenities : _amenities;
    widget.isUpdating
        ? debugPrint('updated button pressed')
        : debugPrint('saved button pressed');
    if (widget.isUpdating) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddImages(
            _currentApartment,
            isUpdating: true,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddImages(
            _currentApartment,
            isUpdating: false,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text('Amenities'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save_alt, color: Colors.white),
              onPressed: _saveAmenities,
            ),
          ],
        ),
      ),
      body: _amenitiesCheckBoxList(),
    );
  }
}
