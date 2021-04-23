import 'package:flutter/material.dart';
import 'package:uhuru/utils/constants.dart';
import 'package:uhuru/widgets/image_picker.dart';
//import '../widgets/profile/profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text('Profile', style: TextStyle(color: COLOR_INDIGO)),
        ),
      ),
     // body: Profile(),
     body: ImagePickerWidget(),
    );
  }
}
