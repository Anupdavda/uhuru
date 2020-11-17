import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:uhuru/providers/personal_apartment_list.dart';
import 'package:uhuru/screens/add_images.dart';
//import 'dart:io';

class AmenitiesScreen extends StatefulWidget {
  static const routeName = '/amenities-screen';

  final PersonalApartment personalApartment;
  final bool isUpdating;
  // final File imageFile;

  AmenitiesScreen(this.personalApartment,
      //this.imageFile,
      {@required this.isUpdating});

  @override
  _AmenitiesScreenState createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends State<AmenitiesScreen> {
  Map<String, bool> _amenities = {
    'air condition': false,
    'ceiling fan': false,
    'ceramic tiles': false,
    'carpet': false,
    'furnished': false,
    'closet': false,
    'elevator': false,
    'laundry': false,
    'security': false,
    'parking': false,
    'swimmingPool': false,
    'hardwoodFloor': false,
  };

  List _amenitiesList = [];
  PersonalApartment _currentApartment;

  @override
  void initState() {
    super.initState();
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    if (personalHomeList.currentApartment != null) {
      _currentApartment = personalHomeList.currentApartment;
    } else {
      _currentApartment = PersonalApartment();
    }
    _amenitiesList.addAll(_currentApartment.amenities);
  }

  Widget _amenitiesCheckBoxList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        shrinkWrap: false,
        children: _amenities.keys.map((String key) {
          return CheckboxListTile(
            title: Text(key),
            value: _amenities[key],
            onChanged: (bool value) {
              setState(() {
                if (value) {
                  _amenities[key] = value;
                  _amenitiesList.add(key);
                } else {
                  _amenities[key] = value;
                  _amenitiesList.remove(key);
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
    _currentApartment.amenities = _amenitiesList;
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

  // uploadAmenities(_currentApartment);

  // uploadApartment(_currentApartment, widget.isUpdating, widget.imageFile,
  //     _apartmentUploaded);
  // Navigator.of(context).popUntil((route) => route.isFirst);

  // _apartmentUploaded(PersonalApartment personalApartment) {
  //   PersonalHomeList personalHomeList =
  //       Provider.of<PersonalHomeList>(context, listen: false);
  //   personalHomeList.addApartment(personalApartment);
  //   //  Navigator.pop(context);
  //   // print('popped Successfully');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Amenities'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save_alt, color: Colors.white),
              onPressed: _saveAmenities,
            ),
          ],
        ),
      ),
      body: _amenitiesCheckBoxList(),
    );
  }
}
