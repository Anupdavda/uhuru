import 'package:flutter/material.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:provider/provider.dart';
//import 'package:uhuru/screens/personal_detail_screen.dart';

class ApartmentCard extends StatelessWidget {
  //  final String id;
  // final String description;
  // final double price;
  // final List imageUrl;
  // final String streetName;
  // final int bedroom;
  // final double bathroom;
  // final String city;
  // final double zipcode;
  // final double area;
  // final List amenities;
  final bool isMe;

  const ApartmentCard(
      // this.id,
      // this.description,
      // this.price,
      // this.imageUrl,
      // this.streetName,
      // this.bedroom,
      // this.bathroom,
      // this.city,
      // this.zipcode,
      // this.area,
      // this.amenities,
      this.isMe,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apartment = Provider.of<PersonalApartment>(context, listen: false);
   // bool isMe = true;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      margin: EdgeInsets.all(4),
      
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: apartment.imageUrl.isEmpty
                  ? Container(
                      child: Center(
                          child: Text(
                        'No Images',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )),
                      height: 250,
                      width: double.infinity,
                      color: Colors.black54)
                  : Image.network(
                      //  imageUrl[0],
                      apartment.imageUrl[0],
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            // apartment.price.toString()
                            apartment.price.toString().replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},'),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(apartment.bedroom.toString() +
                              //  bedroom.toString() +
                              " bd | " +
                              apartment.bathroom.toString() +
                              //  bathroom.toString() +
                              " ba | " +
                              apartment.area.toString() +
                              //area.toString() +
                              " sq-ft"),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          !isMe
                              ? Consumer<PersonalApartment>(
                                  builder: (ctx, product, _) => IconButton(
                                    icon: Icon(
                                      apartment.isFavorite
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                    ),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      apartment.toggleFavoriteStatus();
                                    },
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_city,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(apartment.streetName +
                              //  streetName +
                              ", " +
                              apartment.city +
                              // city +
                              ", " +
                              apartment.zipcode.toString()
                          //   zipcode.toString()
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        
      )
    );
  }
}
