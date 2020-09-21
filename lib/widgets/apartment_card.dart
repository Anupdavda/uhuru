import 'package:flutter/material.dart';
import '../model/apartment.dart';
import 'package:provider/provider.dart';
import '../screens/apartment_detail_screen.dart';

class ApartmentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apartment = Provider.of<Apartment>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      margin: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ApartmentDetailScreen.routeName,
            arguments: apartment.id,
          );
        },
        onDoubleTap: () {
          debugPrint('doubletapped');
        },
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                apartment.imageUrl,
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
                              " bd | " +
                              apartment.bathroom.toString() +
                              " ba | " +
                              apartment.area.toString() +
                              " sq-ft"),
                          //Text(apartment.description),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Consumer<Apartment>(
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
                          ),
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
                          ", " +
                          apartment.city +
                          ", " +
                          apartment.zipcode.toString()),
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
