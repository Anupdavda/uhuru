import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/helper/dynamoDb_api.dart';
import 'package:uhuru/helper/filter_api.dart';
import 'package:uhuru/provider/filter_provider.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
import 'package:uhuru/screens/personal_detail_screen.dart';
import '../widgets/apartment_card.dart';

class ApartmentGrid extends StatefulWidget {
  @override
  _ApartmentGridState createState() => _ApartmentGridState();
}

class _ApartmentGridState extends State<ApartmentGrid> {
  // var _didChangeDependency = true;
  void initState() {
    PersonalHomeList personalApartmentList =
        Provider.of<PersonalHomeList>(context, listen: false);
    //getApartment(personalApartmentList);
    getApartmentFromDynamoDB(personalApartmentList);
    print('init state Length: ' +
        personalApartmentList.loadedPersonalApartment.length.toString());
        

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (_didChangeDependency) {
    try {
      PersonalHomeList personalApartmentList =
          Provider.of<PersonalHomeList>(context, listen: false);
      FilterProvider filterProvider = Provider.of<FilterProvider>(context);
      final cityFilter = filterProvider.filterItems;
      if (cityFilter == null &&
          cityFilter.city == "Any" &&
          cityFilter.minPrice == 0.0 &&
          cityFilter.maxPrice == 0.0) {
        setState(() {
          getApartment(personalApartmentList);
        });
      } else {
        setState(() {
          getApartmentbyCityPrice(
              personalApartmentList,
              cityFilter.city,
              cityFilter.maxPrice,
              cityFilter.minPrice,
              cityFilter.zipcode,
              cityFilter.bathroom,
              cityFilter.amenities);
        });
      }
    } catch (e) {
      print(e);
    }
    //  }
    //  _didChangeDependency = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context);

    FilterProvider filterProvider = Provider.of<FilterProvider>(context);
    final cityFilter = filterProvider.filterItems;

    final personalApartments = cityFilter == null || cityFilter.city == "Any"
        ? personalHomeList.loadedPersonalApartment
        : personalHomeList.loadedPersonalApartmentByCity;
    var user = FirebaseAuth.instance.currentUser;

    if (personalApartments.length == 0) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Consumer<PersonalHomeList>(
        builder: (context, apartmentData, _) => ListView.builder(
          itemCount: personalApartments.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: personalApartments[i],
            child: GestureDetector(
                child: ApartmentCard(
                  personalApartments[i].userId == user.uid,
                ),
                onTap: () {
                  personalHomeList.currentApartment = personalApartments[i];
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return PersonalDetailScreen(
                      personalApartments[i].userId == user.uid,
                    );
                  }));
                }),
          ),
        ),
      );
    }
  }
}
