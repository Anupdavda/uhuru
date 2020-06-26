import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './personal_apartment.dart';
import 'package:uhuru/widgets/personal_home/add_apartment.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, futureSnapshot) {
          return StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (ctx, chatSnapshot) {
                 if (!chatSnapshot.hasData) return AddHome();
                final chatDocs = chatSnapshot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => PersonalApartment(
 
                    chatDocs[index]['address']['city'],
                    chatDocs[index]['address']['streetName'],
                    chatDocs[index]['address']['zipcode'],                   
                    chatDocs[index]['apartment']['area'],
                    chatDocs[index]['apartment']['bathroom'],
                    chatDocs[index]['apartment']['bedroom'],
                    chatDocs[index]['apartment']['description'],
                    chatDocs[index]['apartment']['price'],
                  ),
                );
              });
        });
  }
}

class AddHome extends StatelessWidget {
  const AddHome({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(40, 0, 50, 0),
          child: Text(
            'Do you have a House/Apartment?',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Text(
            'Add your house/apartment to the listing for renting or selling.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          elevation: 10,
          child: Text(
            'Add your House',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu-Bold',
              fontSize: 20,
            ),
          ),
          color: Colors.redAccent,
          onPressed: () {
            Navigator.of(context).pushNamed(AddApartment.routeName);
          },
        ),
      ],
    );
  }
}
