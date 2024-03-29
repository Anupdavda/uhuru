import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/helper/dynamoDb_api.dart';
import 'package:uhuru/model/personal_apartment.dart';
//import 'package:uhuru/model/personal_apartment.dart';
import 'package:uhuru/screens/personal_detail_screen.dart';
//import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/utils/constants.dart';
import '../../provider/personal_apartment_list.dart';
import 'package:uhuru/widgets/personal_home/add_apartment.dart';
import 'package:uhuru/utils/custom_functions.dart';

class PersonalApartmentItem extends StatefulWidget {
  @override
  _PersonalApartmentItemState createState() => _PersonalApartmentItemState();
}

class _PersonalApartmentItemState extends State<PersonalApartmentItem> {
  @override
  void initState() {
    PersonalHomeList personalApartmentList =
        Provider.of<PersonalHomeList>(context, listen: false);
    // getApartmentbyUserId(personalApartmentList);
    getApartmentFromDynamoDB(personalApartmentList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PersonalHomeList personalHomeList = Provider.of<PersonalHomeList>(context);
    final personalApartments = personalHomeList.loadedPersonalApartment;
    // var user = FirebaseAuth.instance.currentUser;

    _apartmentDeleted(PersonalApartment personalApartment) {
      personalHomeList.deleteApartment(personalApartment);
    }

    if (personalApartments.length == 0) {
      return AddHome();
    } else {
      return Consumer<PersonalHomeList>(
        builder: (context, apartmentData, _) => ListView.builder(
          itemCount: personalApartments.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: personalApartments[i],
              child: ListTile(
                leading: personalApartments[i].imageUrl.isEmpty
                    ? CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary)
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(personalApartments[i].imageUrl[0])),
                trailing: IconButton(
                    icon: const Icon(Icons.delete, color: COLOR_REDACCENT),
                    onPressed: () {
                     deleteApartmentsDynamoDb(personalApartments[i], _apartmentDeleted);
                      // deleteApartments(
                      //     personalApartments[i], _apartmentDeleted);
                    }),
                title: Text(
                  "${formatCurrency(personalApartments[i].price)}",

                  style: TEXT_THEME_DEFAULT.headline3,
                  // personalApartments[i].price.toString().replaceAllMapped(
                  //     new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  //     (Match m) => '${m[1]},'),
                  // style: TextStyle(
                  //   fontSize: 20,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
                subtitle: Text(
                    personalApartments[i].streetName +
                        ", " +
                        personalApartments[i].city +
                        ", " +
                        personalApartments[i].zipcode.toString(),
                    style: TEXT_THEME_DEFAULT.bodyText1),
                onTap: () {
                  personalHomeList.currentApartment = personalApartments[i];
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return PersonalDetailScreen(
                        // personalApartments[i].userId == user.uid,
                        );
                  }));
                },
              )
              //  : AddHome(),
              ),
        ),
      );
    }
  }
}

class AddHome extends StatelessWidget {
  const AddHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(40, 0, 50, 0),
          child: const Text(
            'Do you have a House/Apartment?',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: COLOR_BLACK),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: const Text(
            'Add your house/apartment to the listing for renting or selling.',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: COLOR_BLACK),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          //elevation: 10,
          child: const Text(
            'Add your House',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu-Bold',
              fontSize: 20,
            ),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent),

          onPressed: () {
            //  Navigator.of(context).pushNamed(AddApartment.routeName);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddApartment(
                  isUpdating: false,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
