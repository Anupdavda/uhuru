import 'package:flutter/material.dart';
import 'package:uhuru/widgets/filter.dart';

class FilterScreen extends StatelessWidget {
  static const routeName = '/filter-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: const Text('Apply Filter'),
        ),
      ),
      body: Filter(),
    );
  }
}
