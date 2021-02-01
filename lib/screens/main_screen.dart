//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uhuru/screens/personal_home_screen.dart';
import '../screens/apartment_list_screen.dart';
import '../screens/saved_apartments_screen.dart';
import '../screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  final _showFavs = true;

  @override
  void initState() {
    _pages = [
      {
        'page': ApartmentListScreen(),
        // 'title': 'ApartmentList',
      },
      {
        'page': SavedApartmentScreen(_showFavs),
        // 'title': 'Saved Apartments',
      },
      {
        'page': PersonalHomeScreen(),
        // 'title': 'Your Home',
      },
      {
        'page': ProfileScreen(),
        // 'title': 'Your Profile',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize:const Size.fromHeight(50.0),
      //   child: AppBar(
      //     title: const Text('Uhuru'),
      //     backgroundColor: Theme.of(context).accentColor,
      //     elevation: 10,

      //   ),
      // ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          backgroundColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: const Icon(Icons.search),
              // ignore: deprecated_member_use
              label: 'Listings',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: const Icon(Icons.bookmark_border),
              label: 'Saved Homes',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: const Icon(Icons.home),
              label: 'Your Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: const Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
