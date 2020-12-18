import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:uhuru/widgets/image_carousel.dart';

//import '../providers/amenities.dart';
//import '../providers/apartment_list.dart';
//import '../providers/amenities_list.dart';
//import './amenities/amenities_grid.dart';

class ApartmentDetails extends StatelessWidget {
  // final bool showSelectedAmenities;

  // ApartmentDetails(this.showSelectedAmenities);

  final String id;
  final String description;
  final double price;
  final List imageUrl;
  final String streetName;
  final int bedroom;
  final double bathroom;
  final String city;
  final double zipcode;
  final double area;
  final List amenities;

  const ApartmentDetails(
      this.id,
      this.description,
      this.price,
      this.imageUrl,
      this.streetName,
      this.bedroom,
      this.bathroom,
      this.city,
      this.zipcode,
      this.area,
      this.amenities,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productId =
    //     ModalRoute.of(context).settings.arguments as String; // is the id!

    // final loadedApartment = Provider.of<ApartmentList>(
    //   context,
    //   listen: false,
    // ).findById(productId);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImageCarousel(),
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
                         //   loadedApartment.currentApartment.
                            price
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
                             // loadedApartment.currentApartment.
                              bedroom
                                      .toString() +
                                  " bd | " +
                             //     loadedApartment.currentApartment.
                                  bathroom
                                      .toString() +
                                  " ba | " +
                             //     loadedApartment.currentApartment.
                                  area
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
                      Text(//loadedApartment.currentApartment.
                      streetName +
                          ", " +
                         // loadedApartment.currentApartment.
                          city +
                          ", " +
                         // loadedApartment.currentApartment.
                          zipcode.toString()),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(//loadedApartment.currentApartment.
              description),
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
                children:// loadedApartment.
               // currentApartment.
                amenities
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
    );
  }
}
