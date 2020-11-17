import 'package:flutter/material.dart';
import 'package:uhuru/widgets/image_carousel.dart';
//import 'package:uhuru/model/amenities.dart';
//import 'package:uhuru/widgets/amenities/amenities_grid.dart';
import 'package:uhuru/widgets/personal_home/add_apartment.dart';
import 'package:uhuru/providers/personal_apartment_list.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class PersonalDetailScreen extends StatelessWidget {
  static const routeName = '/personal-apartment-detail';
  // List<Amenity> _amenity = [
  //   Amenity(name: 'Air Condition', icon: Icons.ac_unit, isSelected: false),
  //   Amenity(name: 'Ceiling Fan', icon: Icons.ac_unit, isSelected: false),
  //   Amenity(name: 'Ceramic Tiles', icon: Icons.traffic, isSelected: false),
  //   Amenity(name: 'Carpet', icon: Icons.casino, isSelected: false),
  //   Amenity(name: 'Furnished', icon: Icons.shopping_cart, isSelected: false),
  //   Amenity(name: 'Closet', icon: Icons.cake, isSelected: false),
  //   Amenity(name: 'Elevator', icon: Icons.equalizer, isSelected: false),
  //   Amenity(name: 'Laundary', icon: Icons.laptop_mac, isSelected: false),
  //   Amenity(name: 'Security', icon: Icons.security, isSelected: false),
  //   Amenity(name: 'Parking', icon: Icons.local_parking, isSelected: false),
  //   Amenity(
  //       name: 'Swimming Pool', icon: Icons.local_airport, isSelected: false),
  //   Amenity(
  //       name: 'Hardwood Floor', icon: Icons.local_florist, isSelected: false),
  // ];

  @override
  Widget build(BuildContext context) {
    PersonalHomeList loadedApartment =
        Provider.of<PersonalHomeList>(context, listen: true);

    // List<Image> _apartmentImages = [
    //   Image.network(loadedApartment.currentApartment.imageUrl)
    // ];

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
            ImageCarousel(),
            // Container(
            //  // padding: EdgeInsets.all(3),
            //   height: 300,

            //   //   child: ClipRRect(
            //   //     borderRadius: BorderRadius.circular(10.0),
            //   //     child: Image.network(loadedApartment.currentApartment.imageUrl,
            //   //         height: 250, width: double.infinity, fit: BoxFit.cover),
            //   //   ),
            //   child: CarouselSlider.builder(
            //     itemCount: _apartmentImages.length,
            //     itemBuilder: (context, i) {
            //       return Container(
            //         child: Center(
            //           child: Image.network(
            //             loadedApartment.currentApartment.imageUrl,
            //             fit: BoxFit.cover,
            //             height: 300,
            //              width: double.infinity,
            //           ),
            //         ),
            //       );
            //     },
            //     options: CarouselOptions(
            //       autoPlay: false,
            //       aspectRatio: 2.0,
            //       enlargeCenterPage: false,
            //     ),
            //   ),
            // ),
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
              child: Text(loadedApartment.currentApartment.description),
            ),
            SizedBox(height: 16),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text("Amenities", textAlign: TextAlign.left),
            ),
            SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            //   child: GridView.builder(
            //     itemCount: _amenity.length,
            //     itemBuilder: (context, index) => Row(
            //       children: [
            //         Icon(_amenity[index].icon),
            //         SizedBox(width: 10),
            //         Text(_amenity[index].name),
            //       ],
            //     ),
            //     shrinkWrap: true,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       childAspectRatio: 5 / 1,
            //       crossAxisSpacing: 20,
            //       mainAxisSpacing: 10,
            //     ),
            //     // crossAxisCount: 2,`
            //     // childAspectRatio: 5 / 1,
            //     // crossAxisSpacing: 80,
            //     // mainAxisSpacing: 10,
            //     // children: loadedApartment.currentApartment.amenities
            //     //     .map((amenities) => Text(amenities))
            //     //     .toList(),
            //   ),
            //   //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(54, 0, 54, 0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 5 / 1,
                crossAxisSpacing: 80,
                mainAxisSpacing: 10,
                children: loadedApartment.currentApartment.amenities
                    .map((amenities) => Text(amenities))
                    .toList(),
              ),
            ),
            SizedBox(height: 16),
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
      // ),
    );
  }
}
