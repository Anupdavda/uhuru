import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:uhuru/screens/personal_detail_screen.dart';

 import 'package:uhuru/helper/apartment_api.dart';
import '../../providers/personal_apartment_list.dart';

import 'package:uhuru/widgets/personal_home/add_apartment.dart';

class PersonalApartmentItem extends StatefulWidget {
  @override
  _PersonalApartmentItemState createState() => _PersonalApartmentItemState();
}

class _PersonalApartmentItemState extends State<PersonalApartmentItem> {
  @override
  void initState() {
    PersonalHomeList personalApartmentList =
        Provider.of<PersonalHomeList>(context, listen: false);
     getApartment(personalApartmentList);
    print('Length: ' +
        personalApartmentList.loadedPersonalApartment.length.toString());
    super.initState();
  }

  // deleteApartment(PersonalApartment personalApartment) {
  //   // PersonalHomeList personalHomeList = Provider.of<PersonalHomeList>(context);
  //   // personalHomeList.deleteApartment(personalApartment);
  //   Provider.of<PersonalHomeList>(context,listen:false).deleteApartments(id, personalApartment);
  // }

  @override
  Widget build(BuildContext context) {
    // final personalApartment =
    //     Provider.of<PersonalApartment>(context, listen: false);
    PersonalHomeList personalHomeList = Provider.of<PersonalHomeList>(context);
    final personalApartments = personalHomeList.loadedPersonalApartment;

    if (personalApartments.length == 0) {
      return AddHome();
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
                    child: ListTile(
                    leading: Image.network(personalApartments[i].imageUrl),
                    trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () async {
                        }
                       
                        ),
                    title: Text(
                   personalApartments[i]. price.toString().replaceAllMapped(
                          new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},'),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(personalApartments[i].streetName +
                        ", " +
                       personalApartments[i].city +
                        ", " +
                        personalApartments[i].zipcode.toString()),
                    onTap: () {
                     personalHomeList.currentApartment = personalApartments[i];
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return PersonalDetailScreen();
                }));
                    },
                  )),
              ),
            );
          });
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
          margin: EdgeInsets.fromLTRB(40, 0, 50, 0),
          child: Text(
            'Do you have a House/Apartment?',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Text(
            'Add your house/apartment to the listing for renting or selling.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          elevation: 10,
          child: Text(
            'Add your House',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu-Bold',
              fontSize: 20,
            ),
          ),
          color: Colors.redAccent,
          onPressed: () {
            Navigator.of(context).pushNamed(AddApartment.routeName);
          },
        ),
      ],
    );
  }
}
