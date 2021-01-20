//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
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
                        personalApartments[i].id == futureSnapshot.data.uid,
                      ),
                      onTap: () {
                        personalHomeList.currentApartment =
                            personalApartments[i];
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return PersonalDetailScreen(
                            personalApartments[i].id == futureSnapshot.data.uid,
                          );
                        }));
                      }),
                ),
              ),
            );
          });
    }
  }
}
