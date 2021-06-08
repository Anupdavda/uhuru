import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:uhuru/provider/personal_apartment_list.dart';

class AddImages extends StatefulWidget {
  final PersonalApartment personalApartment;
  final bool isUpdating;

  const AddImages(this.personalApartment, {@required this.isUpdating});

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<Asset> images = [];
  List imageUrls = [];
  String _error = 'No Error Dectected';
  PersonalApartment _currentApartment;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    if (personalHomeList.currentApartment != null && widget.isUpdating) {
      _currentApartment = personalHomeList.currentApartment;
    } else {
      _currentApartment = PersonalApartment(
        id: widget.personalApartment.id,
        amenities: widget.personalApartment.amenities,
        area: widget.personalApartment.area,
        bathroom: widget.personalApartment.bathroom,
        bedroom: widget.personalApartment.bedroom,
        city: widget.personalApartment.city,
        description: widget.personalApartment.description,
        imageUrl: widget.personalApartment.imageUrl,
        price: widget.personalApartment.price,
        streetName: widget.personalApartment.streetName,
        zipcode: widget.personalApartment.zipcode,
      );
    }
    imageUrls.addAll(_currentApartment.imageUrl);
  }

  Map<String, dynamic> toMaps() {
    return {
      'description': _currentApartment.description,
      'price': _currentApartment.price,
      'imageUrl': _currentApartment.imageUrl,
      'streetName': _currentApartment.streetName,
      'bedroom': _currentApartment.bedroom,
      'bathroom': _currentApartment.bathroom,
      'city': _currentApartment.city,
      'zipcode': _currentApartment.zipcode,
      'area': _currentApartment.area,
      'amenities': _currentApartment.amenities,
    };
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    //String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      _error = e.toString();
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;
    setState(() {
      images = resultList;
      // _currentApartment.imageUrl = images;
      //_error = error;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    var url = Uri.parse(
        'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos/image-upload');

    http
        .post(url,
            body: jsonEncode(
                (await imageFile.getByteData()).buffer.asUint8List()))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      print(statusCode.toString());

      if (statusCode == 200) {
        print('Success to Image DynamoDB');

        return;
      } else {
        throw new Exception("Error while fetching data");
      }
    });

    // final ref = FirebaseStorage.instance
    //     .ref()
    //     .child(user.uid)
    //     .child(Timestamp.now().toString() + '.jpg');
    // UploadTask uploadTask =
    //     ref.putData((await imageFile.getByteData()).buffer.asUint8List());
    // TaskSnapshot storageTaskSnapshot = await uploadTask;
    // debugPrint("Images Uploaded to the database");
    // print(storageTaskSnapshot.ref.getDownloadURL());
    // return storageTaskSnapshot.ref.getDownloadURL();
  }

  void uploadImages() async {
    CollectionReference apartmentRef =
        FirebaseFirestore.instance.collection('apartments');

    if (images.isNotEmpty) {
      for (var imageFile in images) {
        postImage(imageFile).then((downloadUrl) async {
          imageUrls.add(downloadUrl.toString());

          if (imageUrls.length == images.length) {
            if (widget.isUpdating) {
              _currentApartment.updatedAt = Timestamp.now();
              _currentApartment.imageUrl = imageUrls;

              await apartmentRef
                  .doc(_currentApartment.id)
                  .update(_currentApartment.toMap());

              _apartmentUploaded(_currentApartment);
              print('updated apartment with id: ${_currentApartment.id}');
            } else {
              _currentApartment = widget.personalApartment;
              _currentApartment.createdAt = Timestamp.now();

              _currentApartment.userId = user.uid;

              DocumentReference documentRef =
                  await apartmentRef.add(_currentApartment.toMap());
              _currentApartment.id = documentRef.id;
              _currentApartment.imageUrl = imageUrls;
              await documentRef.set(
                  _currentApartment.toMap(), SetOptions(merge: true));
              _apartmentUploaded(_currentApartment);
              print(
                  'uploaded apartment successfully: ${_currentApartment.toString()}');
            }
            setState(() {
              images = [];
              imageUrls = [];
            });
          }
        }).catchError((err) {
          _error = err;
          print(_error);
        });
      }
    } else {
      if (widget.isUpdating) {
        _currentApartment.updatedAt = Timestamp.now();

        await apartmentRef
            .doc(_currentApartment.id)
            .update(_currentApartment.toMap());

        _apartmentUploaded(_currentApartment);
        print('updated apartment with id: ${_currentApartment.id}');
      } else {
        _currentApartment = widget.personalApartment;
        _currentApartment.createdAt = Timestamp.now();

        DocumentReference documentRef =
            await apartmentRef.add(_currentApartment.toMap());
        _currentApartment.id = user.uid;

        await documentRef.set(
            _currentApartment.toMap(), SetOptions(merge: true));
        _apartmentUploaded(_currentApartment);
      }
    }
  }

  _apartmentUploaded(PersonalApartment personalApartment) {
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    personalHomeList.addApartment(personalApartment);
    Navigator.of(context).popUntil((route) => route.isFirst);
    debugPrint('popped Successfully');
  }

  _saveImages() {
    //  uploadImages();
    addImageToS3();

    if (widget.isUpdating) {
      updateApartmentInDynamoDB();
    } else {
      addApartmentToDynamoDB();
    }
  }

  Future<void> addImageToS3() async {
    for (var imageFile in images) {
      postImage(imageFile);
    }
  }

  Future<void> updateApartmentInDynamoDB() async {
    String id = _currentApartment.id;
    var updateUrl =
        'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos/' +
            id;
    var urlUpdate = Uri.parse(updateUrl);
    print(updateUrl);

    if (images.isNotEmpty) {
      for (var imageFile in images) {
        postImage(imageFile).then((downloadUrl) async {
          imageUrls.add(downloadUrl.toString());
          if (imageUrls.length == images.length) {
            _currentApartment.updatedAt = Timestamp.now();
            _currentApartment.imageUrl = imageUrls;

            http
                .put(
              urlUpdate,
              body: jsonEncode(<String, dynamic>{
                'description': _currentApartment.description,
                'price': _currentApartment.price,
                'imageUrl': _currentApartment.imageUrl,
                'streetName': _currentApartment.streetName,
                'bedroom': _currentApartment.bedroom,
                'bathroom': _currentApartment.bathroom,
                'city': _currentApartment.city,
                'zipcode': _currentApartment.zipcode,
                'area': _currentApartment.area,
                'amenities': _currentApartment.amenities,
              }),
            )
                .then((http.Response response) {
              final int statusCode = response.statusCode;
              if (statusCode == 200) {
                print('updated to DynamoDB');
                return;
              } else {
                throw new Exception("Error while fetching data");
              }
            });
            _apartmentUploaded(_currentApartment);
            print('updated apartment with id: ${_currentApartment.id}');

            setState(() {
              images = [];
              imageUrls = [];
            });
          }
        }).catchError((err) {
          _error = err;
          print(_error);
        });
      }
    } else {
      _currentApartment.updatedAt = Timestamp.now();
      _currentApartment.imageUrl = imageUrls;

      http
          .put(
        urlUpdate,
        body: jsonEncode(<String, dynamic>{
          'description': _currentApartment.description,
          'price': _currentApartment.price,
          'imageUrl': _currentApartment.imageUrl,
          'streetName': _currentApartment.streetName,
          'bedroom': _currentApartment.bedroom,
          'bathroom': _currentApartment.bathroom,
          'city': _currentApartment.city,
          'zipcode': _currentApartment.zipcode,
          'area': _currentApartment.area,
          'amenities': _currentApartment.amenities,
        }),
      )
          .then((http.Response response) {
        final int statusCode = response.statusCode;
        if (statusCode == 200) {
          print('updated to DynamoDB');
          return;
        } else {
          throw new Exception("Error while fetching data");
        }
      });
      _apartmentUploaded(_currentApartment);
      print('updated apartment with id: ${_currentApartment.id}');
    }
  }

  Future<void> addApartmentToDynamoDB() async {
    String id = _currentApartment.id;
    print(id);
    var urlCreate = Uri.parse(
        'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos');

    if (images.isNotEmpty) {
      for (var imageFile in images) {
        postImage(imageFile).then((downloadUrl) async {
          imageUrls.add(downloadUrl.toString());

          if (imageUrls.length == images.length) {
            _currentApartment = widget.personalApartment;

            _currentApartment.imageUrl = imageUrls;
            http
                .post(
              urlCreate,
              body: jsonEncode(<String, dynamic>{
                'description': _currentApartment.description,
                'price': _currentApartment.price,
                'imageUrl': _currentApartment.imageUrl,
                'streetName': _currentApartment.streetName,
                'bedroom': _currentApartment.bedroom,
                'bathroom': _currentApartment.bathroom,
                'city': _currentApartment.city,
                'zipcode': _currentApartment.zipcode,
                'area': _currentApartment.area,
                'amenities': _currentApartment.amenities
              }),
            )
                .then((http.Response response) {
              final int statusCode = response.statusCode;
              if (statusCode == 200) {
                print('Success to DynamoDB');
                return;
              } else {
                throw new Exception("Error while fetching data");
              }
            });
            _apartmentUploaded(_currentApartment);
          }
          setState(() {
            images = [];
            imageUrls = [];
          });
        }).catchError((err) {
          _error = err;
          print(_error);
        });
      }
    } else {
      _currentApartment = widget.personalApartment;
      http
          .post(urlCreate,
              body: jsonEncode(<String, dynamic>{
                'description': _currentApartment.description,
                'price': _currentApartment.price,
                'imageUrl': _currentApartment.imageUrl,
                'streetName': _currentApartment.streetName,
                'bedroom': _currentApartment.bedroom,
                'bathroom': _currentApartment.bathroom,
                'city': _currentApartment.city,
                'zipcode': _currentApartment.zipcode,
                'area': _currentApartment.area,
                'amenities': _currentApartment.amenities
              }))
          .then((http.Response response) {
        print(response.statusCode);
        final int statusCode = response.statusCode;
        if (statusCode == 200) {
          print('Success to DynamoDB');
          return;
        } else {
          throw new Exception("Error while fetching data");
        }
      });
      _apartmentUploaded(_currentApartment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text('Add Images'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.save_alt, color: Colors.white),
                onPressed: () {
                  _saveImages();
                }),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(child: const Text('Add your apartment images.')),
          ElevatedButton(
            child: const Text("Pick images"),
            onPressed: loadAssets,
          ),
          Expanded(
            child: buildGridView(),
          )
        ],
      ),
    );
  }
}
