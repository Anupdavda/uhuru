import 'package:flutter/material.dart';
import 'package:uhuru/utils/constants.dart';
//import '../widgets/personal_home/personal_apartment_card.dart';
import '../widgets/personal_home/personal_apartment_item.dart';
import '../widgets/personal_home/add_apartment.dart';

class PersonalHomeScreen extends StatefulWidget {
  static const routeName = '/personalHome-screen';
  @override
  _PersonalHomeScreenState createState() => _PersonalHomeScreenState();
}

class _PersonalHomeScreenState extends State<PersonalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: const Text('Your Home'),
          
        ),
      ),
      body: PersonalApartmentItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return AddApartment(
                isUpdating: false,
              );
            }),
          );
        },
        child:const Icon(
          Icons.add,
          color: COLOR_WHITE,
        ),
      ),
    );
  }
}
