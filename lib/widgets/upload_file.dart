import 'dart:io';

import 'package:http/http.dart' as http;

class UploadFile {
  bool success;
  String message;

  bool isUploaded = true;
  

  Future<void> call(String urls, File image) async {
   print('call started');
   var url = Uri.parse(urls);
   http.post(url, body: image.readAsBytes()).then((http.Response response) => print(response.statusCode.toString()));
    
    try {

      // var response = await http.post(url, body: image.readAsBytesSync());
      
      // if (response.statusCode == 200) {
      //   isUploaded = true;
      //   print('uploadded');
      // }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}
