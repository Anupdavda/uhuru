// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';

// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:uhuru/helper/apartment_api.dart';
// import 'package:uhuru/model/personal_apartment.dart';
// import 'package:uhuru/providers/personal_apartment_list.dart';

// class AddImages extends StatefulWidget {
//   final PersonalApartment personalApartment;
//   final bool isUpdating;

//   AddImages(this.personalApartment, {@required this.isUpdating});

//   @override
//   _AddImagesState createState() => _AddImagesState();
// }

// class _AddImagesState extends State<AddImages> {
//   List<Asset> images = List<Asset>();
//   String _error = 'No Error Dectected';
//    PersonalApartment _currentApartment;

//   @override
//   void initState() {
//     super.initState();
//     PersonalHomeList personalHomeList =
//         Provider.of<PersonalHomeList>(context, listen: false);
//     if (personalHomeList.currentApartment != null) {
//       _currentApartment = personalHomeList.currentApartment;
//     } else {
//       _currentApartment = PersonalApartment();
//     }

    
//     debugPrint(widget.isUpdating.toString());
//   }

//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   }

//   Future<void> loadAssets() async {
//     List<Asset> resultList = List<Asset>();
//     String error = 'No Error Dectected';

//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 10,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }
//    setState(() {
//      images = resultList;
//    });
   
   

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     // if (!mounted) return;

//     // setState(() {
//     //   images = resultList;
//     //   _currentApartment.imageUrl = images;
//     //   _error = error;
//     // });
//   }





//   _apartmentUploaded(PersonalApartment personalApartment) {
//     PersonalHomeList personalHomeList =
//         Provider.of<PersonalHomeList>(context, listen: false);
//     personalHomeList.addApartment(personalApartment);
//     Navigator.pop(context);
//     print('popped Successfully');
//   }
  

//   _saveImages() {
//     // uploadImageFiles(_currentApartment);

//     uploadApartment(_currentApartment, widget.isUpdating,   images,
//         _apartmentUploaded);
//     Navigator.of(context).popUntil((route) => route.isFirst);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50.0),
//         child: AppBar(
//           backgroundColor: Theme.of(context).accentColor,
//           title: Text('Add Images'),
//            actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.save_alt, color: Colors.white),
//                 onPressed: () {
//                   _saveImages();
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AddImages(
//                                 _currentApartment,
//                                 isUpdating: false,
//                               )));
//                 }),
//           ],
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Center(child: Text('Add your apartment images.')),
//           RaisedButton(
//             child: Text("Pick images"),
//             onPressed: loadAssets,
//           ),
//           Expanded(
//             child: buildGridView(),
//           )
//         ],
//       ),
//     );
//   }
// }
