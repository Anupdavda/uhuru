import 'package:flutter/material.dart';

class AmenitiesScreen extends StatefulWidget {
  static const routeName = '/amenities-screen';
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
    'closed': false,
    'elevator': false,
    'laundry': false,
    'security': false,
    'parking': false,
    'swimmingPool': false,
    'hardwoodFloor': false,
  };

  List _amenitiesList = [];

  Widget _amenitiesCheckBoxList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        shrinkWrap: false,
        children: _amenities.keys.map((String key) {
          return new CheckboxListTile(
            title: Text(key),
            value: _amenities[key],
            onChanged: (bool value) {
              setState(() {
                if (value) {
                  _amenities[key] = value;
                  _amenitiesList.add(value);
                } else {
                  _amenitiesList.remove(value);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

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
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: _amenitiesCheckBoxList(),
    );
  }
}
