import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uhuru/provider/filter_provider.dart';
//import 'dart:ui';
import './screens/main_screen.dart';
import './screens/auth_screen.dart';
import 'provider/personal_apartment_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
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
        ChangeNotifierProvider.value(
          value: FilterProvider(),
        ),
        ChangeNotifierProvider.value(
          value: PersonalHomeList(),
        ),
      ],
      child: MaterialApp(
        title: 'Uhuru',
  
        theme: ThemeData(
          //primaryColor: COLOR_GREEN,
         // accentColor: COLOR_BLUEACCENT,
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if (userSnapshot.hasData) {
                return MainScreen();
              } else {
                return AuthScreen();
              }
            }),
      ),
    );
  }
}
