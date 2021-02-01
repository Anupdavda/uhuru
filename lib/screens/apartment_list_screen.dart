import 'package:flutter/material.dart';
import 'package:uhuru/screens/filter_screen.dart';
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
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: const Text('Listing'),
          actions: [
            IconButton(
              icon: const Icon(Icons.sort_rounded),
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
