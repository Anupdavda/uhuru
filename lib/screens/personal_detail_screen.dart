import 'package:flutter/material.dart';
import 'package:uhuru/widgets/image_carousel.dart';
import 'package:uhuru/widgets/personal_home/add_apartment.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/utils/constants.dart';
import 'package:uhuru/utils/custom_functions.dart';

class PersonalDetailScreen extends StatelessWidget {
  static const routeName = '/personal-apartment-detail';

  // final bool isMe;

  // const PersonalDetailScreen(this.isMe, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersonalHomeList loadedApartment =
        Provider.of<PersonalHomeList>(context, listen: true);
    bool isMe = true;
    //final ThemeData themeData = Theme.of(context);
    final _amenities = loadedApartment.currentApartment.amenities;
    var _amenitiesKeys = _amenities.keys.toList();
    var _amenitiesValues = _amenities.values.toList();
    // List _trueAmenitiesValues = [];
    List _trueAmenitiesKeys = [];

    for (int i = 0; i < _amenitiesValues.length; i++) {
      if (_amenitiesValues[i] == true) {
      //  _trueAmenitiesValues.add(_amenitiesValues[i]);
        _trueAmenitiesKeys.add(_amenitiesKeys[i]);
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: COLOR_WHITE,
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
            ImageCarousel(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // const Icon(
                          //   Icons.monetization_on,
                          // ),
                          // SizedBox(
                          //   width: 6,
                          // ),
                          Text(
                            "${formatCurrency(loadedApartment.currentApartment.price)}",

                            style: TEXT_THEME_DEFAULT.headline3,
                            // loadedApartment.currentApartment.price
                            //     .toString()
                            //     .replaceAllMapped(
                            //         new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            //         (Match m) => '${m[1]},'),
                            // style: TextStyle(
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.bold,
                            // ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
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
                                  " sq-ft",
                              style: TEXT_THEME_DEFAULT.headline5),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_city,
                      ),
                      const SizedBox(width: 6),
                      Text(
                          loadedApartment.currentApartment.streetName +
                              ", " +
                              loadedApartment.currentApartment.city +
                              ", " +
                              loadedApartment.currentApartment.zipcode
                                  .toString(),
                          style: TEXT_THEME_DEFAULT.headline5),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(loadedApartment.currentApartment.description,
                  style: TEXT_THEME_DEFAULT.headline4),
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: const Text("Amenities",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: COLOR_BLACK,
                    fontSize: 16,
                  )),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(54, 0, 54, 0),
              child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 1,
                  crossAxisSpacing: 80,
                  mainAxisSpacing: 10,
                  children: List.generate(
                      _trueAmenitiesKeys.length,
                      (index) => Text(_trueAmenitiesKeys[index],
                          style: TEXT_THEME_DEFAULT.headline4))),
            ),
            const SizedBox(height: 16),
            isMe
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      child: const Text('Contact Seller',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      style: TextButton.styleFrom(
                          primary: COLOR_INDIGO),
                      onPressed: () {},
                    ),
                  ),
          ],
        ),
      ),
      // ),
    );
  }
}
