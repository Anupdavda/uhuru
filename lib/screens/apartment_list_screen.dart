import 'package:flutter/material.dart';
import '../widgets/apartment_grid.dart';

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
