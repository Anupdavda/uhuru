import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uhuru/widgets/personal_home/add_apartment.dart';

class PersonalApartment extends StatelessWidget {
  final String city;
  final String streetName;
  final double zipcode;
  final double area;
  final double bathroom;
  final int bedroom;
  final String description;
  final double price;

  PersonalApartment(this.city, this.streetName, this.zipcode, this.area,
      this.bathroom, this.bedroom, this.description, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      margin: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   ApartmentDetailScreen.routeName,
          //   arguments: apartment.id,
          //  );
        },
        child: Column(
          children: <Widget>[
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10.0),
            //   child: Image.network(
            //     apartment.imageUrl,
            //     height: 250,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
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
                            price.toString().replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},'),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Text(
                          //   apartment.price.toString().replaceAllMapped(
                          //       new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          //       (Match m) => '${m[1]},'),
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Text(apartment.bedroom.toString() +
                          //     " bd | " +
                          //     apartment.bathroom.toString() +
                          //     " ba | " +
                          //     apartment.area.toString() +
                          //     " sq-ft"),
                          //Text(apartment.description),
                          Text(bedroom.toString() +
                              " bd | " +
                              bathroom.toString() +
                              " ba | " +
                              area.toString() +
                              " sq-ft"),
                          Text(description),
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
                      // Text(apartment.streetName +
                      //     ", " +
                      //     apartment.city +
                      //     ", " +
                      //     apartment.zipcode.toString()),
                      Text(
                          streetName + ", " + city + ", " + zipcode.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
