// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class UserImagePicker extends StatefulWidget {
//   UserImagePicker(this.imagePickFn);

//   final Function(File pickedImage) imagePickFn;

//   @override
//   _UserImagePickerState createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   File _pickedImage;

//   void _pickImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.getImage(
//       source: ImageSource.camera,
//        imageQuality: 80,
//     );
//     final pickedImageFile = File(pickedImage.path);
//     setState(() {
//       _pickedImage = pickedImageFile;
//     });
//     widget.imagePickFn(pickedImageFile);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           width: 150,
//           height: 100,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.grey),
//           ),
//           child: _pickedImage != null ? Image.file((_pickedImage)) : null,
//         ),
//         FlatButton.icon(
//           onPressed: _pickImage,
//           icon: Icon(Icons.image),
//           label: Text('Add Image'),
//           textColor: Theme.of(context).primaryColor,
//         ),
//       ],
//     );
//   }
// }
