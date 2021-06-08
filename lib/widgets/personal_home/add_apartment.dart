import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';
import 'package:uhuru/screens/amenities_screen.dart';


class AddApartment extends StatefulWidget {
  final bool isUpdating;

  const AddApartment({@required this.isUpdating});

  static const routeName = '/add-apartment';

  @override
  _AddApartmentState createState() => _AddApartmentState();
}

class _AddApartmentState extends State<AddApartment> {
  PersonalApartment _currentApartment;
 
  final _form = GlobalKey<FormState>();
  final _areaFocusNode = FocusNode();
  final _bedroomFocusNode = FocusNode();
  final _bathroomFocusNode = FocusNode();
  final _streetFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _zipFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    if (personalHomeList.currentApartment != null &&
        widget.isUpdating == true) {
      _currentApartment = personalHomeList.currentApartment;
    } else {
      _currentApartment = PersonalApartment(
        id: '',
        amenities: _amenities,
        area: 0.0,
        bathroom: 0.0,
        bedroom: 0,
        city: '',
        description: '',
        imageUrl: [],
        price: 0.0,
        streetName: '',
        zipcode: 0.0,
      );
    }
  }

  Map<String, bool> _amenities = {
    'air condition': false,
    'ceiling fan': false,
    'ceramic tiles': false,
    'carpet': false,
    'furnished': false,
    'closet': false,
    'elevator': false,
    'laundry': false,
    'security': false,
    'parking': false,
    'swimmingPool': false,
    'hardwoodFloor': false,
  };

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      debugPrint(_currentApartment.price.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AmenitiesScreen(
            _currentApartment,
            //  _apartmentImage,
            isUpdating: false,
          ),
        ),
      );
    }
  }

  Future<void> _updatingForm() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AmenitiesScreen(
            _currentApartment,
            //  _apartmentImage,
            isUpdating: true,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _areaFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _bedroomFocusNode.dispose();
    _bathroomFocusNode.dispose();
    _streetFocusNode.dispose();
    _cityFocusNode.dispose();
    _zipFocusNode.dispose();
    super.dispose();
  }

  Widget _priceTextFormField() {
    return TextFormField(
      initialValue: //_initValues['price'],
          _currentApartment.price.toString(),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Price',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_areaFocusNode);
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
        _currentApartment.price = double.parse(value);
      },
    );
  }

  Widget _areaTextFormField() {
    return TextFormField(
      initialValue: // _initValues['area'],
          _currentApartment.area.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Sqaure-Space',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _areaFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a square-space.';
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
        _currentApartment.area = double.parse(value);
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_bedroomFocusNode);
      },
    );
  }

  Widget _bedroomTextFormField() {
    return TextFormField(
      initialValue: //  _initValues['bedroom'],
          _currentApartment.bedroom.toString(),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _bedroomFocusNode,
      decoration: InputDecoration(
        labelText: 'Bedrooms',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
        _currentApartment.bedroom = int.parse(value);
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_bathroomFocusNode);
      },
    );
  }

  Widget _bathroomTextFormField() {
    return TextFormField(
      initialValue: // _initValues['bathroom'],
          _currentApartment.bathroom.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Bathrooms',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      textInputAction: TextInputAction.next,
      focusNode: _bathroomFocusNode,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter valid number of bathrooms.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter number of bathrooms.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _currentApartment.bathroom = double.parse(value);
      },
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_streetFocusNode);
      },
    );
  }

  Widget _cityTextFormField() {
    return TextFormField(
      initialValue: //_initValues['city'],
          _currentApartment.city,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'City',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      focusNode: _cityFocusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_zipFocusNode);
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
        _currentApartment.city = value;
      },
    );
  }

  Widget _streetnameTextFormField() {
    return TextFormField(
      initialValue: // _initValues['streetName'],
          _currentApartment.streetName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Street Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
        _currentApartment.streetName = value;
      },
    );
  }

  Widget _zipcodeTextFormField() {
    return TextFormField(
      initialValue: //_initValues['zipcode'],
          _currentApartment.zipcode.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Zip Code/P.O.Box',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter valid Zipcode/P.O.Box.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter valid Zipcode/P.O.Box.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _currentApartment.zipcode = double.parse(value);
      },
      focusNode: _zipFocusNode,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_descriptionFocusNode);
      },
    );
  }

  Widget _descriptionTextFormField() {
    return TextFormField(
      initialValue: // _initValues['description'],
          _currentApartment.description,
      textInputAction: TextInputAction.done,
      maxLines: null,
      decoration: InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
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
        _currentApartment.description = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(widget.isUpdating ? 'Edit Apartment' : 'Add Apartment'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                // UserImagePicker(_pickedImage),
                //_showImage(),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text("Details", textAlign: TextAlign.left),
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: <Widget>[
                    Flexible(
                        //Price
                        child: _priceTextFormField()),
                    SizedBox(width: 12),
                    Flexible(
                        //Square Space
                        child: _areaTextFormField()),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    //Bedrooms
                    Flexible(child: _bedroomTextFormField()),
                    const SizedBox(width: 12),
                    //Bathrooms
                    Flexible(child: _bathroomTextFormField()),
                  ],
                ),
                // Address
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text("Address", textAlign: TextAlign.left),
                ),
                const SizedBox(height: 15.0),
                // street name
                _streetnameTextFormField(),
                const SizedBox(height: 5.0),
                //City
                Row(
                  children: <Widget>[
                    Flexible(child: _cityTextFormField()),
                    const SizedBox(width: 12),
                    Flexible(child: _zipcodeTextFormField())
                  ],
                ),
                const SizedBox(height: 15.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text("Description", textAlign: TextAlign.left),
                ),
                const SizedBox(height: 15.0),
                _descriptionTextFormField(),
                const SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {
                      widget.isUpdating ? _updatingForm() : _saveForm();

                      widget.isUpdating
                          ? debugPrint('updated button pressed')
                          : debugPrint('saved button pressed');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
