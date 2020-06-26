import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../providers/amenities.dart';
import '../providers/apartment_list.dart';
//import '../providers/amenities_list.dart';
import './amenities/amenities_grid.dart';

class ApartmentDetails extends StatelessWidget {
  // final bool showSelectedAmenities;

  // ApartmentDetails(this.showSelectedAmenities);

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!

    final loadedApartment = Provider.of<ApartmentList>(
      context,
      listen: false,
    ).findById(productId);

    // final amenitiesData = Provider.of<AmenitiesList>(context);
    // final selectedAmenities = amenitiesData.selectedAmenities;
    // showSelectedAmenities ? amenitiesData.selectedAmenities : null;

    //   final amenity = Provider.of<Amenity>(context, listen: false);
    // final amenitiesData = Provider.of<AmenitiesList>(context);
    // final amenities = amenitiesData.amenitiesList;
    // final amenity = Provider.of<Amenity>(context, listen: false);

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(3),
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        loadedApartment.imageUrl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
                                  loadedApartment.price
                                      .toString()
                                      .replaceAllMapped(
                                          new RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
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
                                Text(loadedApartment.bedroom.toString() +
                                    " bd | " +
                                    loadedApartment.bathroom.toString() +
                                    " ba | " +
                                    loadedApartment.area.toString() +
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
                            Text(loadedApartment.streetName +
                                ", " +
                                loadedApartment.city +
                                ", " +
                                loadedApartment.zipcode.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Expanded(child: Text(loadedApartment.description)),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ),
        // SliverGrid.count(
        //   children: <Widget>[
        //     GridView.builder(
        //       itemCount: amenities.length,
        //       physics: new NeverScrollableScrollPhysics(),
        //       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //           value: amenities[i],
        //           child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               mainAxisAlignment: MainAxisAlignment.spaceAround,
        //               children: [
        //                 Icon(amenity.icon, size: 20),
        //                 SizedBox(width: 10),
        //                 Expanded(child: Text(amenity.title)),
        //               ])),
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2,
        //         childAspectRatio: 5 / 1,
        //         crossAxisSpacing: 10,
        //         mainAxisSpacing: 1,
        //       ),
        //     )
        //   ],
        //   crossAxisCount: 1,
        // ),
        SliverGrid.count(
          children: <Widget>[Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: AmenitiesGrid(),
          )],
          crossAxisCount: 1,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RaisedButton(
                    child: Text('Contact Seller',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Ubuntu-Bold',
                          fontSize: 20,
                        )),
                    color: Colors.redAccent,
                    onPressed: () {},
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
