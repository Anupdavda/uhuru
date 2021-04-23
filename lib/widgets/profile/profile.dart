//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uhuru/utils/constants.dart';

import 'package:trotter/trotter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _form = GlobalKey<FormState>();
  bool isChecked = false;

  _onSaved() {
    final amenities = [
          'price',
          'area',
          'bathroom',
          'bedroom',
          'city',
          'zipcode',
          'amenities'
        ],
        combos1 = Combinations(1, amenities),
        combos2 = Combinations(2, amenities),
        combos3 = Combinations(3, amenities),
        combos4 = Combinations(4, amenities),
        combos5 = Combinations(5, amenities),
        combos6 = Combinations(6, amenities),
        combos7 = Combinations(7, amenities);

    for (final combo in combos1()) {
      print(combo);
    }
    for (final combo in combos2()) {
      print(combo);
    }
    for (final combo in combos3()) {
      print(combo);
    }
    for (final combo in combos4()) {
      print(combo);
    }
    for (final combo in combos5()) {
      print(combo);
    }
    for (final combo in combos6()) {
      print(combo);
    }
    for (final combo in combos7()) {
      print(combo);
    }
  }

  _filterCondition() {
    final amenities = [
          'minPrice != null && maxPrice != null',
          'maxPrice == 0.0 && minPrice == 0.0',
          'city.isNotEmpty && city != "Any"',
          'city == "Any"',
          'area.start = 500 && area.start = 20000',
          'area.start != null',
          'area.end != null',
          'zipcode != null',
          'zipcode == null'
        ],
        combos1 = Combinations(1, amenities),
        combos2 = Combinations(2, amenities),
        combos3 = Combinations(3, amenities),
        combos4 = Combinations(4, amenities),
        combos5 = Combinations(5, amenities),
        combos6 = Combinations(6, amenities),
        combos7 = Combinations(7, amenities),
        combos8 = Combinations(8, amenities),
        combos9 = Combinations(9, amenities);
        

    for (final combo in combos1()) {
      print(combo);
    }
    for (final combo in combos2()) {
      print(combo);
    }
    for (final combo in combos3()) {
      print(combo);
    }
    for (final combo in combos4()) {
      print(combo);
    }
    for (final combo in combos5()) {
      print(combo);
    }
    for (final combo in combos6()) {
      print(combo);
    }
    for (final combo in combos7()) {
      print(combo);
    }
    for (final combo in combos8()) {
      print(combo);
    }
    for (final combo in combos9()) {
      print(combo);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      key: _form,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: ' Last Name',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'E-mail',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Mobile Number',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Address',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Feedback',
                  style: TextStyle(
                    color: COLOR_BLACK,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: const Text(
                    'Help Support',
                    style: TextStyle(color: COLOR_BLACK),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: const Text(
                    'Customer Support',
                    style: TextStyle(color: COLOR_BLACK),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: const Text(
                    'Rate',
                    style: TextStyle(color: COLOR_BLACK),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(
            color: Colors.grey,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                      value: isChecked,
                      onChanged: (bool value) {
                        setState(() {
                          isChecked = value;
                        });
                      }),
                  const Text('Read and accept terms and agreements'),
                  const SizedBox(height: 16.0),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: const Text('Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {
                    // FirebaseAuth.instance.signOut();
                     _onSaved();
                    _filterCondition();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
