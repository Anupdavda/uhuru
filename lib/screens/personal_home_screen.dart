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
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: COLOR_INDIGO, //change your color here
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'Your Home',
            style: TextStyle(color: COLOR_INDIGO),
        ),
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
        child: const Icon(
          Icons.add,
          color: COLOR_WHITE,
        ),
      ),
    );
  }
}
