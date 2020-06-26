import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:uhuru/providers/apartment.dart';
// import 'package:uhuru/providers/apartment_list.dart';
// import 'package:uhuru/providers/personal_home_list.dart';
import 'package:uhuru/widgets/amenities/amenities_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddApartment extends StatefulWidget {
  static const routeName = '/add-apartment';

  @override
  _AddApartmentState createState() => _AddApartmentState();
}

class _AddApartmentState extends State<AddApartment> {
  final _form = GlobalKey<FormState>();

  final _areaFocusNode = FocusNode();
  final _bedroomFocusNode = FocusNode();
  final _bathroomFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  double _price = 0.0;
  String _description = '';
  double _area = 0.0;
  int _bedroom = 0;
  double _bathroom = 0;
  double _zipcode = 0.0;
  String _streetName = '';
  String _city = '';

  void _trySubmit() async {
    final isValid = _form.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _form.currentState.save();

      var firebaseUser = await FirebaseAuth.instance.currentUser();
      Firestore.instance
          .collection("users")
          .document(firebaseUser.uid)
          .setData({
        'apartment': {
          'description': _description,
          'price': _price,
          'area': _area,
          'bedroom': _bedroom,
          'bathroom': _bathroom
        },
        'address': {
          'streetName': _streetName,
          'city': _city,
          'zipcode': _zipcode,
        }
      });
      Navigator.of(context).pop();
    }
  }

 

  // var _addApartmentToList = Apartment(
  //   id: null,
  //   price: 0,
  //   description: '',
  //   imageUrl:
  //       'https://upload.wikimedia.org/wikipedia/commons/7/76/Vuojoen_kartano_8.jpg',
  //   area: 0,
  //   bedroom: 0,
  //   bathroom: 0,
  //   zipcode: 0,
  //   streetName: '',
  //   city: '',
  // );

  // void _savedForm() {
  //   final isValid = _form.currentState.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _form.currentState.save();
  //   if (_addApartmentToList.id == null) {
  //     Provider.of<ApartmentList>(context, listen: false)
  //         .addApartment(_addApartmentToList);
  //     Provider.of<PersonalHomeList>(context, listen: false)
  //         .addApartment(_addApartmentToList);
  //   }
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Add Apartment'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save_alt, color: Colors.white),
              // onPressed: () {
              //   _savedForm();
              // },
              onPressed: _trySubmit,
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Details", textAlign: TextAlign.left),
                        ),

                        SizedBox(height: 15.0),
                        Row(
                          children: <Widget>[
                            Flexible(
                              //Price
                              child: TextFormField(
                                // initialValue: _initValues['price'],
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'Price',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_areaFocusNode);
                                  debugPrint('Scope is pressed');
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a price.';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number.';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _price = double.parse(value);
                                  // _addApartmentToList = Apartment(
                                  //     price: double.parse(value),
                                  //     description:
                                  //         _addApartmentToList.description,
                                  //     imageUrl: _addApartmentToList.imageUrl,
                                  //     id: _addApartmentToList.id,
                                  //     area: _addApartmentToList.area,
                                  //     bedroom: _addApartmentToList.bedroom,
                                  //     bathroom: _addApartmentToList.bathroom,
                                  //     zipcode: _addApartmentToList.zipcode,
                                  //     streetName:
                                  //         _addApartmentToList.streetName,
                                  //     city: _addApartmentToList.city,
                                  //     isFavorite:
                                  //         _addApartmentToList.isFavorite);
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Flexible(
                              //Square Space
                              child: TextFormField(
                                //   initialValue: _initValues['description'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Sqaure-Space',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                textInputAction: TextInputAction.next,
                                focusNode: _areaFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a square-space.';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number.';
                                  }
                                  if (int.parse(value) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _area = double.parse(value);
                                  // _addApartmentToList = Apartment(
                                  //     price: _addApartmentToList.price,
                                  //     description:
                                  //        _addApartmentToList.description,
                                  //     imageUrl: _addApartmentToList.imageUrl,
                                  //     id: _addApartmentToList.id,
                                  //     area: int.parse(value),
                                  //     bedroom: _addApartmentToList.bedroom,
                                  //     bathroom: _addApartmentToList.bathroom,
                                  //     zipcode: _addApartmentToList.zipcode,
                                  //     streetName:
                                  //         _addApartmentToList.streetName,
                                  //     city: _addApartmentToList.city,
                                  //     isFavorite:
                                  //         _addApartmentToList.isFavorite);
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_bedroomFocusNode);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            //Bedrooms
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                focusNode: _bedroomFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Bedrooms',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid number of bedrooms.';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter number of bedrooms.';
                                  }
                                  if (int.parse(value) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _bedroom = int.parse(value);
                                  // _addApartmentToList = Apartment(
                                  //     //   address: _addApartmentToList.address,
                                  //     //   details: _addApartmentToList.details,
                                  //     price: _addApartmentToList.price,
                                  //     description:
                                  //         _addApartmentToList.description,
                                  //     imageUrl: _addApartmentToList.imageUrl,
                                  //     id: _addApartmentToList.id,
                                  //     area: _addApartmentToList.area,
                                  //     bedroom: int.parse(value),
                                  //     bathroom: _addApartmentToList.bathroom,
                                  //     zipcode: _addApartmentToList.zipcode,
                                  //     streetName:
                                  //         _addApartmentToList.streetName,
                                  //     city: _addApartmentToList.city,
                                  //     isFavorite:
                                  //         _addApartmentToList.isFavorite);
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_bathroomFocusNode);
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            //Bathrooms
                            Flexible(
                              child: TextFormField(
                                //   initialValue: _initValues['description'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Bathrooms',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                textInputAction: TextInputAction.next,
                                focusNode: _bathroomFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid number of bathrooms.';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter number of bathrooms.';
                                  }
                                  if (int.parse(value) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _bathroom = double.parse(value);
                                  // _addApartmentToList = Apartment(
                                  //     price: _addApartmentToList.price,
                                  //     description:
                                  //         _addApartmentToList.description,
                                  //     imageUrl: _addApartmentToList.imageUrl,
                                  //     id: _addApartmentToList.id,
                                  //     area: _addApartmentToList.area,
                                  //     bedroom: _addApartmentToList.bedroom,
                                  //     bathroom: int.parse(value),
                                  //     zipcode: _addApartmentToList.zipcode,
                                  //     streetName:
                                  //         _addApartmentToList.streetName,
                                  //     city: _addApartmentToList.city,
                                  //     isFavorite:
                                  //         _addApartmentToList.isFavorite);
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_streetFocusNode);
                                },
                              ),
                            ),
                          ],
                        ),
                        // Address
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Address", textAlign: TextAlign.left),
                        ),
                        SizedBox(height: 15.0),
                        // street name
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Street Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          focusNode: _streetFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_cityFocusNode);
                            debugPrint('Scope is pressed');
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter street name.';
                            }
                            if (value.length < 10) {
                              return 'Should be at least 10 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _streetName = value;
                            // _addApartmentToList = Apartment(
                            //     price: _addApartmentToList.price,
                            //     description: _addApartmentToList.description,
                            //     imageUrl: _addApartmentToList.imageUrl,
                            //     id: _addApartmentToList.id,
                            //     area: _addApartmentToList.area,
                            //     bedroom: _addApartmentToList.bedroom,
                            //     bathroom: _addApartmentToList.bathroom,
                            //     zipcode: _addApartmentToList.zipcode,
                            //     streetName: value,
                            //     city: _addApartmentToList.city,
                            //     isFavorite: _addApartmentToList.isFavorite);
                          },
                        ),
                        SizedBox(height: 5.0),
                        //City
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                // initialValue: _initValues['price'],
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                focusNode: _cityFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_zipFocusNode);
                                  debugPrint('Scope is pressed');
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a city.';
                                  }
                                  if (value.length > 1 && value.length < 5) {
                                    return 'Should be at least 5 characters long.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _city = value;
                                  // _addApartmentToList = Apartment(
                                  //     price: _addApartmentToList.price,
                                  //     description:
                                  //         _addApartmentToList.description,
                                  //     imageUrl: _addApartmentToList.imageUrl,
                                  //     id: _addApartmentToList.id,
                                  //     area: _addApartmentToList.area,
                                  //     bedroom: _addApartmentToList.bedroom,
                                  //     bathroom: _addApartmentToList.bathroom,
                                  //     zipcode: _addApartmentToList.zipcode,
                                  //     streetName:
                                  //         _addApartmentToList.streetName,
                                  //     city: value,
                                  //     isFavorite:
                                  //         _addApartmentToList.isFavorite);
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Flexible(
                              child: TextFormField(
                                //   initialValue: _initValues['description'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Zip Code/P.O.Box',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter valid Zipcode/P.O.Box.';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter valid Zipcode/P.O.Box.';
                                  }
                                  if (int.parse(value) <= 0) {
                                    return 'Please enter a number greater than zero.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _zipcode = double.parse(value);
                                  // _addApartmentToList = Apartment(
                                  //     price: _addApartmentToList.price,
                                  //     description:
                                  //         _addApartmentToList.description,
                                  //     imageUrl: _addApartmentToList.imageUrl,
                                  //     id: _addApartmentToList.id,
                                  //     area: _addApartmentToList.area,
                                  //     bedroom: _addApartmentToList.bedroom,
                                  //     bathroom: _addApartmentToList.bathroom,
                                  //     zipcode: int.parse(value),
                                  //     streetName:
                                  //         _addApartmentToList.streetName,
                                  //     city: _addApartmentToList.city,
                                  //     isFavorite:
                                  //         _addApartmentToList.isFavorite);
                                },
                                focusNode: _zipFocusNode,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_descriptionFocusNode);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Description", textAlign: TextAlign.left),
                        ),
                        SizedBox(height: 15.0),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a description.';
                            }
                            if (value.length < 10) {
                              return 'Should be at least 10 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _description = value;
                            // _addApartmentToList = Apartment(
                            //   price: _addApartmentToList.price,
                            //   description: value,
                            //   imageUrl: _addApartmentToList.imageUrl,
                            //   id: _addApartmentToList.id,
                            //   area: _addApartmentToList.area,
                            //   bedroom: _addApartmentToList.bedroom,
                            //   bathroom: _addApartmentToList.bathroom,
                            //   zipcode: _addApartmentToList.zipcode,
                            //   streetName: _addApartmentToList.streetName,
                            //   city: _addApartmentToList.city,
                            //   isFavorite: _addApartmentToList.isFavorite,
                            // );
                          },
                        ),
                        SizedBox(height: 15.0),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Amenities", textAlign: TextAlign.left),
                        ),
                        //    AmenitiesList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverGrid.count(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: AmenitiesGrid(),
              )
            ],
            crossAxisCount: 1,
          ),
        ],
      ),
    );
  }
}
