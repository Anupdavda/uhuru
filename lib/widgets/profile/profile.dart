import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _form = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      key: _form,
      child: ListView(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'First Name',
              
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: ' Last Name',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'E-mail',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Mobile Number',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Address',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Feedback',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: const Text(
                    'Help Support',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: const Text(
                    'Customer Support',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: const Text(
                    'Rate',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(
            color: Colors.grey,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                      value: isChecked,
                      onChanged: (bool value) {
                        setState(() {
                          isChecked = value;
                        });
                      }),
                  const Text('Read and accept terms and agreements'),
                  const SizedBox(height: 16.0),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: const Text('Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
