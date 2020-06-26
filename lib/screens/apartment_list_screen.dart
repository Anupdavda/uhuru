import 'package:flutter/material.dart';
import '../widgets/apartment_grid.dart';
//import 'package:uhuru/widgets/apartment_list_item.dart';
//import '../widgets/apartment_card.dart';
// import 'package:provider/provider.dart';
// import '../providers/apartment_list.dart';

//import '../providers/apartment_list.dart';

class ApartmentListScreen extends StatefulWidget {
  @override
  _ApartmentListScreenState createState() => _ApartmentListScreenState();
}

class _ApartmentListScreenState extends State<ApartmentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ApartmentGrid(),
    );
  }
}
