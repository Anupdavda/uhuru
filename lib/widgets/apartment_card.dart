import 'package:flutter/material.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:provider/provider.dart';

class ApartmentCard extends StatelessWidget {
  final bool isMe;

  const ApartmentCard(this.isMe, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apartment = Provider.of<PersonalApartment>(context, listen: false);

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8,
        margin: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: apartment.imageUrl.isEmpty
                  ? Container(
                      child: const Center(
                          child: const Text(
                        'No Images',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )),
                      height: 250,
                      width: double.infinity,
                      color: Colors.black54)
                  : Image.network(
                      apartment.imageUrl[0],
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.monetization_on,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            apartment.price.toString().replaceAllMapped(
                                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                (Match m) => '${m[1]},'),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800,
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
                          const SizedBox(width: 6),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_city,
                      ),
                      const SizedBox(width: 6),
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
        ));
  }
}
