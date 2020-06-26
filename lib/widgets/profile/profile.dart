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
                child: Text(
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
                  title: Text(
                    'Help Support',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: Text(
                    'Customer Support',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {},
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  title: Text(
                    'Rate',
                    style: TextStyle(color: Colors.green),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
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
                  Text('Read and accept terms and agreements'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
