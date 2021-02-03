import 'package:flutter/material.dart';
import 'package:uhuru/screens/filter_screen.dart';
import 'package:uhuru/utils/constants.dart';
import '../widgets/apartment_grid.dart';

class ApartmentListScreen extends StatefulWidget {
  @override
  _ApartmentListScreenState createState() => _ApartmentListScreenState();
}

class _ApartmentListScreenState extends State<ApartmentListScreen> {
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
            'Listing',
            style: TextStyle(color: COLOR_INDIGO),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: COLOR_INDIGO),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return FilterScreen();
                }));
              },
            )
          ],
        ),
      ),
      body: ApartmentGrid(),
    );
  }
}
