//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/providers/personal_apartment_list.dart';
import 'package:uhuru/screens/personal_detail_screen.dart';
import '../widgets/apartment_card.dart';
//import '../providers/apartment_list.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_auth/firebase_auth.dart';

class ApartmentGrid extends StatefulWidget {
  @override
  _ApartmentGridState createState() => _ApartmentGridState();
}

class _ApartmentGridState extends State<ApartmentGrid> {
  void initState() {
    PersonalHomeList personalApartmentList =
        Provider.of<PersonalHomeList>(context, listen: false);
    getApartment(personalApartmentList);
    print('Length: ' +
        personalApartmentList.loadedPersonalApartment.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final apartmentData = Provider.of<ApartmentList>(context);
    // final apartment = apartmentData.loadedApartment;
    //  final productId =
    //     ModalRoute.of(context).settings.arguments as String; // is the id!
    //  final loadedApartments = Provider.of<ApartmentList>(
    //   context,
    //   listen: false,
    // ).findById(productId);

    final PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context);
    final personalApartments = personalHomeList.loadedPersonalApartment;

    if (personalApartments.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (context, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Consumer<PersonalHomeList>(
              builder: (context, apartmentData, _) => ListView.builder(
                itemCount: personalApartments.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: personalApartments[i],
                  child: GestureDetector(
                      child: ApartmentCard(
                        
                      ),
                      onTap: () {
                          personalHomeList.currentApartment =
                            personalApartments[i];
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return PersonalDetailScreen();
                        }));
                      }),
                ),
              ),
            );
          });
    }

    // return ListView.builder(
    //   itemCount: apartment.length,
    //   itemBuilder: (ctx, i) =>  ChangeNotifierProvider.value(
    //       value: apartment[i],
    //       child: ApartmentCard(

    //       ),
    //     ),

    // );

    // return FutureBuilder(
    //     future: FirebaseAuth.instance.currentUser(),
    //     builder: (context, futureSnapshot) {
    //       if (futureSnapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       return StreamBuilder(
    //           stream: Firestore.instance
    //               .collection('apartments')
    //               // .orderBy('createdAt', descending: true)
    //               .snapshots(),
    //           builder: (ctx, apartmentSnapshot) {
    //             if (!apartmentSnapshot.hasData) return Text('Loading');
    //             // if (apartmentSnapshot.connectionState == ConnectionState.waiting) {
    //             //   return Center(child: CircularProgressIndicator());
    //             // }
    //             final apartmentDocs = apartmentSnapshot.data.documents;

    //             return ListView.builder(
    //               reverse: true,
    //               itemCount: apartmentDocs.length,
    //               itemBuilder: (ctx, index) => ApartmentItem(
    //                 apartmentDocs[index]['id'],
    //                 apartmentDocs[index]['description'],
    //                 apartmentDocs[index]['price'],
    //                 apartmentDocs[index]['imageUrl'],
    //                 apartmentDocs[index]['streetName'],
    //                 apartmentDocs[index]['bedroom'],
    //                 apartmentDocs[index]['bathroom'],
    //                 apartmentDocs[index]['city'],
    //                 apartmentDocs[index]['zipcode'],
    //                 apartmentDocs[index]['area'],
    //                 apartmentDocs[index]['amenities'],
    //                 key: ValueKey(apartmentDocs[index].documentID),
    //               ),
    //             );
    //           });
    //     });
  }
}
