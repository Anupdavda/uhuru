import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
//import 'package:uhuru/model/gallery_item.dart';
//import 'package:uhuru/widgets/custom_dialog.dart';
//import 'package:uhuru/widgets/gallery_photo_wrapper.dart';
import 'package:uhuru/widgets/generate_image_url.dart';
// import 'package:uhuru/widgets/upload_file.dart';
// import 'package:uuid/uuid.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

enum PhotoStatus { LOADING, ERROR, LOADED }
enum PhotoSource { FILE, NETWORK }

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  // List<File> _photos = [];
  // List<String> _photosUrls = [];

  // List<PhotoStatus> _photosStatus = [];
  // List<PhotoSource> _photosSources = [];
  // List<GalleryItem> _galleryItems = [];

  // SharedPreferences sharedPreferences;

//   @override
//   void initState() {
//     super.initState();

//  //   loadImages();
//   }

  // loadImages() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   List<String> photos = sharedPreferences.getStringList("images");
  //   if (photos == null) {
  //     return;
  //   }

  //   int length = photos.length;

  //   _galleryItems = List.generate(
  //     length,
  //     (index) => GalleryItem(
  //       isSvg: false,
  //       id: Uuid().v1(),
  //       resource: photos[index],
  //     ),
  //   );
  //   _photos = List.generate(
  //     length,
  //     (index) => File(
  //       photos[index],
  //     ),
  //   );
  //   _photosUrls = List.generate(
  //     length,
  //     (index) => photos[index],
  //   );
  //   _photosStatus = List.generate(
  //     length,
  //     (index) => PhotoStatus.LOADED,
  //   );
  //   _photosSources = List.generate(
  //     length,
  //     (index) => PhotoSource.NETWORK,
  //   );
  //   setState(() {});
  // }

  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future<bool> uploadFile(context, String urls, File image) async {
      var url = Uri.parse(urls);

      try {
        // var req = http.MultipartRequest('PUT', url);

        // req.files.add(http.MultipartFile.fromBytes(
        //   'file',
        //   image.readAsBytesSync(),
        // ));
        // var res = await req.send();
        // print('UPLOAD: ${res.statusCode}');

        http.put(url, body: image.readAsBytesSync(), headers: {
          "Content-Type": "image/jpeg"
        }).then((response) => print(response.statusCode));

        // UploadFile uploadFile;
        // //String urls = 'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos/image-upload';
        // print('e');
        //  uploadFile.call(url, image);
        //  Dio dio;
        // Response uploadRes = await dio.put(urls,
        //     data: image.readAsBytesSync().buffer.asUint8List(),
        //     options: Options(
        //       contentType: "image/jpeg",
        //       headers: {
        //         "Content-Length": image.lengthSync(),
        //       },
        //     ));
        //print("uploadRes.statusCode, ${uploadRes.statusCode}");
        // http
        //     .put(url,
        //         headers: {"Content-Type": "application/json"},
        //         body: image.readAsBytesSync())
        //     .then((http.Response response) {
        //   print(response.statusCode);
        //   print(response.reasonPhrase);
        // });

        return true;
      } catch (e) {
        print(e.toString());
      }
      return true;
    }

    _onAddPhotoClicked(context) async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
      String fileExtension = path.extension(_image.path);
      try {
        GenerateImageUrl generateImageUrl = GenerateImageUrl();
        await generateImageUrl.call(fileExtension);

        String uploadUrl;
        if (generateImageUrl.isGenerated != null &&
            generateImageUrl.isGenerated) {
          uploadUrl = generateImageUrl.uploadUrl;
        } else {
          throw generateImageUrl.message;
        }

        bool isUploaded = await uploadFile(context, uploadUrl, _image);
        if (isUploaded) {
          print('Uploaded');
        }
      } catch (e) {
        print(e);
      }
    }

    return Column(
      children: [
        Center(
          child:
              _image == null ? Text('No image selected.') : Image.file(_image),
        ),
        ElevatedButton(
          //elevation: 10,
          child: const Text('get image'),
          style: ElevatedButton.styleFrom(primary: Colors.redAccent),

          onPressed: () => _onAddPhotoClicked(context),
        ),
      ],
    );
    //   return Scaffold(
    //     body: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Container(
    //           height: 100,
    //           child: ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: _photos.length + 1,
    //             itemBuilder: (context, index) {
    //               if (index == 0) {
    //                 return _buildAddPhoto();
    //               }
    //               File image = _photos[index - 1];
    //               PhotoSource source = _photosSources[index - 1];
    //               return Stack(
    //                 children: <Widget>[
    //                   InkWell(
    //                     onTap: () => _onPhotoClicked(index - 1),
    //                     child: Container(
    //                       margin: EdgeInsets.all(5),
    //                       height: 100,
    //                       width: 100,
    //                       color: Colors.grey,
    //                       child: source == PhotoSource.FILE
    //                           ? Image.file(image)
    //                           : Image.network(_photosUrls[index - 1]),
    //                     ),
    //                   ),
    //                   // Visibility(
    //                   //   visible: _photosStatus[index - 1] == PhotoStatus.LOADING,
    //                   //   child: Positioned.fill(
    //                   //     child: SpinKitWave(
    //                   //       size: 25,
    //                   //       color: Colors.white,
    //                   //     ),
    //                   //   ),
    //                   // ),

    //                   Positioned.fill(
    //                     child: Container(
    //                       padding: EdgeInsets.all(6),
    //                       alignment: Alignment.topRight,
    //                       //   child:
    //                       //  DeleteWidget(
    //                       //   () => _onDeleteReviewPhotoClicked(index - 1),
    //                       // ),
    //                     ),
    //                   )
    //                 ],
    //               );
    //             },
    //           ),
    //         ),
    //         Container(
    //           margin: EdgeInsets.all(16),
    //           child: RaisedButton(
    //             child: Text('Save'),
    //             onPressed: _onSaveClicked,
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }

    // _onSaveClicked() async {
    //   try {
    //     sharedPreferences = await SharedPreferences.getInstance();
    //     await sharedPreferences.setStringList("images", _photosUrls);
    //     print('Successfully saved');
    //   } catch (e) {
    //     print('Error saving ');
    //   }
    // }

    // // Future<bool> _onDeleteReviewPhotoClicked(int index) async {
    // //   if (_photosStatus[index] == PhotoStatus.LOADED) {
    // //     _photosUrls.removeAt(index);
    // //   }
    // //   _photos.removeAt(index);
    // //   _photosStatus.removeAt(index);
    // //   _photosSources.removeAt(index);
    // //   _galleryItems.removeAt(index);
    // //   setState(() {});
    // //   return true;
    // // }

    // _buildAddPhoto() {
    //   return InkWell(
    //     onTap: () => _onAddPhotoClicked(context),
    //     child: Container(
    //       margin: EdgeInsets.all(5),
    //       height: 100,
    //       width: 100,
    //       // color: kDarkGray,
    //       child: Center(
    //         child: Icon(
    //           Icons.add,
    //         ),
    //       ),
    //     ),
    //   );
    // }

    // _onAddPhotoClicked(context) async {
    //   // Permission permission;

    //   // if (Platform.isIOS) {
    //   //   permission = Permission.photos;
    //   // } else {
    //   //   permission = Permission.storage;
    //   // }

    //   // PermissionStatus permissionStatus = await permission.status;

    //   //  print(permissionStatus);

    //   // if (permissionStatus == PermissionStatus.restricted) {
    //   //   _showOpenAppSettingsDialog(context);

    //   //   permissionStatus = await permission.status;

    //   //   if (permissionStatus != PermissionStatus.granted) {
    //   //     //Only continue if permission granted
    //   //     return;
    //   //   }
    //   // }

    //   // if (permissionStatus == PermissionStatus.permanentlyDenied) {
    //   //   _showOpenAppSettingsDialog(context);

    //   //   permissionStatus = await permission.status;

    //   //   if (permissionStatus != PermissionStatus.granted) {
    //   //     //Only continue if permission granted
    //   //     return;
    //   //   }
    //   // }

    //   // if (permissionStatus == PermissionStatus.undetermined) {
    //   //   permissionStatus = await permission.request();

    //   //   if (permissionStatus != PermissionStatus.granted) {
    //   //     //Only continue if permission granted
    //   //     return;
    //   //   }
    //   // }

    //   // if (permissionStatus == PermissionStatus.denied) {
    //   //   if (Platform.isIOS) {
    //   //     _showOpenAppSettingsDialog(context);
    //   //   } else {
    //   //     permissionStatus = await permission.request();
    //   //   }

    //   //   if (permissionStatus != PermissionStatus.granted) {
    //   //     //Only continue if permission granted
    //   //     return;
    //   //   }
    //   // }

    //   // if (permissionStatus == PermissionStatus.granted) {
    //   //   print('Permission granted');
    //   ImagePicker imagePicker;
    //   var image = await imagePicker.getImage(
    //     source: ImageSource.gallery,
    //   );

    //   if (image != null) {
    //     int length;
    //     length = _photos.length + 1;
    //     debugPrint('imageFileName: ' + image.path.toString());
    //     String fileExtension = path.extension(image.path);
    //     // String fileExtension = image.path.toString();
    //     debugPrint('fileExtension: ' + fileExtension.toString());

    //     _galleryItems.add(
    //       GalleryItem(
    //         id: Uuid().v1(),
    //         resource: image.path,
    //         isSvg: fileExtension.toLowerCase() == ".svg",
    //       ),
    //     );

    //     setState(() {
    //       _photos.add(File(image.path));
    //       _photosStatus.add(PhotoStatus.LOADING);
    //       _photosSources.add(PhotoSource.FILE);
    //     });

    //     try {
    //       GenerateImageUrl generateImageUrl = GenerateImageUrl();
    //       await generateImageUrl.call(fileExtension);

    //       String uploadUrl;
    //       if (generateImageUrl.isGenerated != null &&
    //           generateImageUrl.isGenerated) {
    //         uploadUrl = generateImageUrl.uploadUrl;

    //         print(uploadUrl);
    //       } else {
    //         print('failed to upload');
    //         throw generateImageUrl.message;
    //       }
    //    var imageFile = File(image.path);
    //       bool isUploaded = await uploadFile(context, uploadUrl, imageFile);
    //       print('isUploaded ' + isUploaded.toString());
    //       if (isUploaded) {
    //         print('Uploaded');
    //         setState(() {
    //           _photosUrls.add(generateImageUrl.downloadUrl);
    //           _photosStatus
    //               .replaceRange(length - 1, length, [PhotoStatus.LOADED]);
    //           _galleryItems[length - 1].resource = generateImageUrl.downloadUrl;
    //         });
    //       }
    //     } catch (e) {
    //       print('eoorr');
    //       print(e);
    //       setState(() {
    //         _photosStatus[length - 1] = PhotoStatus.ERROR;
    //       });
    //     }
    //   }
    //   //   }
    // }

    // // _showOpenAppSettingsDialog(context) {
    // //   return CustomDialog.show(
    // //     context,
    // //     'Permission needed',
    // //     'Photos permission is needed to select photos',
    // //     'Open settings',
    // //     openAppSettings,
    // //   );
    // // }

    // Future<bool> uploadFile(context, String urls, File image) async {
    //   var url = Uri.parse(urls);

    //   try {

    //     // UploadFile uploadFile;
    //     // //String urls = 'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos/image-upload';
    //     // print('e');
    //     //  uploadFile.call(url, image);

    //     http
    //         .put(url, body: image.readAsBytesSync())
    //         .then((http.Response response) {

    //       print( response.reasonPhrase);
    //     });

    //     return true;
    //     // if (uploadFile.isUploaded != null && uploadFile.isUploaded) {
    //     //   return true;
    //     // } else {
    //     //   throw uploadFile.message;
    //     // }
    //   } catch (e) {
    //     print('f');
    //     print(e.toString());
    //     throw e;
    //   }
    // }

    // _onPhotoClicked(int index) {
    //   if (_photosStatus[index] == PhotoStatus.ERROR) {
    //     print("Try uploading again");
    //     return;
    //   }

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => GalleryPhotoViewWrapper(
    //         galleryItems: _galleryItems,
    //         photoStatus: _photosStatus[index],
    //         backgroundDecoration: const BoxDecoration(
    //           color: Colors.black,
    //         ),
    //         initialIndex: index,
    //         scrollDirection: Axis.horizontal,
    //       ),
    //     ),
    //   );
  }
}
