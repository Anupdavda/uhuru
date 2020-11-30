import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
//import 'package:uhuru/helper/apartment_api.dart';
import 'package:uhuru/model/personal_apartment.dart';
import 'package:uhuru/providers/personal_apartment_list.dart';

class AddImages extends StatefulWidget {
  final PersonalApartment personalApartment;
  final bool isUpdating;

  AddImages(this.personalApartment, {@required this.isUpdating});

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<Asset> images = List<Asset>();
  List imageUrls = [];
  String _error = 'No Error Dectected';
  PersonalApartment _currentApartment;

  @override
  void initState() {
    super.initState();
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    if (personalHomeList.currentApartment != null) {
      _currentApartment = personalHomeList.currentApartment;
    } else {
      _currentApartment = PersonalApartment();
    }
    imageUrls.addAll(_currentApartment.imageUrl);
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
    List<Asset> resultList = List<Asset>();
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
    final ref = FirebaseStorage.instance
        .ref()
        .child('apartment_images')
        .child(Timestamp.now().toString() + '.jpg');
    StorageUploadTask uploadTask =
        ref.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    debugPrint("Images Uploaded to the database");
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  void uploadImages() async {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) async {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          CollectionReference apartmentRef =
              Firestore.instance.collection('apartments');
          if (widget.isUpdating) {
            _currentApartment.updatedAt = Timestamp.now();

            await apartmentRef
                .document(_currentApartment.id)
                .updateData(_currentApartment.toMap());

            _apartmentUploaded(_currentApartment);
            print('updated apartment with id: ${_currentApartment.id}');
          } else {
            _currentApartment = widget.personalApartment;
            _currentApartment.createdAt = Timestamp.now();

            DocumentReference documentRef =
                await apartmentRef.add(_currentApartment.toMap());
            _currentApartment.id = documentRef.documentID;
            _currentApartment.imageUrl = imageUrls;
            await documentRef.setData(_currentApartment.toMap(), merge: true);
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
        print(err);
      });
    }
  }

  _apartmentUploaded(PersonalApartment personalApartment) {
    PersonalHomeList personalHomeList =
        Provider.of<PersonalHomeList>(context, listen: false);
    personalHomeList.addApartment(personalApartment);
    Navigator.pop(context);
    print('popped Successfully');
  }

  _saveImages() {
    // uploadApartment(
    //     _currentApartment, widget.isUpdating, images, _apartmentUploaded);
    uploadImages();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Add Images'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save_alt, color: Colors.white),
                onPressed: () {
                  _saveImages();
                  Navigator.of(context).popUntil((route) => route.isFirst);
          
                }),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(child: Text('Add your apartment images.')),
          RaisedButton(
            child: Text("Pick images"),
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