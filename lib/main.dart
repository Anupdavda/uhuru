import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/main_screen.dart';
import './screens/auth_screen.dart';
import 'provider/personal_apartment_list.dart';


void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: ApartmentList(),
        // ),
        // ChangeNotifierProvider.value(
        //   value: AmenitiesList(),
        // ),
        ChangeNotifierProvider.value(
          value: PersonalHomeList(),
        ),
      ],
      child: MaterialApp(
        title: 'Uhuru',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.greenAccent[400],
          fontFamily: 'Ubuntu',
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.green,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return MainScreen();
              } else {
                return AuthScreen();
              }
            }),
        routes: {
        //  ApartmentDetailScreen.routeName: (ctx) => ApartmentDetailScreen(),
     //     AddApartment.routeName: (ctx) => AddApartment(isUpdating: false),
       //   PersonalDetailScreen.routeName: (ctx) => PersonalDetailScreen(),
         // AmenitiesScreen.routeName: (ctx) => AmenitiesScreen(),
        },
      ),
    );
  }
}
