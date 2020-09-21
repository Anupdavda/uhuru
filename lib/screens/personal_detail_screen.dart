import 'package:flutter/material.dart';
//import 'package:uhuru/widgets/amenities/amenities_grid.dart';
import 'package:uhuru/widgets/personal_home/add_apartment.dart';
import 'package:uhuru/providers/personal_apartment_list.dart';

import 'package:provider/provider.dart';

class PersonalDetailScreen extends StatelessWidget {
  static const routeName = '/personal-apartment-detail';

  @override
  Widget build(BuildContext context) {
    PersonalHomeList loadedApartment =
        Provider.of<PersonalHomeList>(context, listen: true);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return AddApartment(
                      isUpdating: true,
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(3),
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(loadedApartment.currentApartment.imageUrl,
                    height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            loadedApartment.currentApartment.price
                                .toString()
                                .replaceAllMapped(
                                    new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                              loadedApartment.currentApartment.bedroom
                                      .toString() +
                                  " bd | " +
                                  loadedApartment.currentApartment.bathroom
                                      .toString() +
                                  " ba | " +
                                  loadedApartment.currentApartment.area
                                      .toString() +
                                  " sq-ft"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_city,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(loadedApartment.currentApartment.streetName +
                          ", " +
                          loadedApartment.currentApartment.city +
                          ", " +
                          loadedApartment.currentApartment.zipcode.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Expanded(
                  child: Text(loadedApartment.currentApartment.description)),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              crossAxisCount: 2,
              childAspectRatio: 5 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 1,
              children: loadedApartment.currentApartment.amenities
                  .map((amenities) => Text(amenities))
                  .toList(),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                child: Text('Contact Seller',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
