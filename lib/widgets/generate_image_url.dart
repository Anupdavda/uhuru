import 'dart:convert';
import 'package:http/http.dart' as http;

class GenerateImageUrl {
  bool success;
  String message;

  bool isGenerated;

  String uploadUrl;
  String downloadUrl;

  Future<void> call(String fileType) async {
    var url = Uri.parse(
        'https://jgnj8beti2.execute-api.us-east-1.amazonaws.com/dev/todos/image-upload');

    try {
       Map bodies = {"fileType": fileType};

      var response = await http.post(
        //For IOS
//        'http://localhost:5000/generatePresignedUrl',
        //For Android

        url,
        body:  bodies //jsonEncode(fileType),
      );

      Map result = jsonDecode(response.body);

      Map fan = {"fan": 1};
      print(fan);
      print(fan['fan']);

      print(result);
      print(result['uploadURL']);

      //   if (result['success'] != null) {
      // success = result['success'];
      // message = result['message'];
      print(response.statusCode);

      if (response.statusCode == 200) {
        isGenerated = true;
        uploadUrl = result['uploadURL'];
        downloadUrl = result["photoFilename"];
        // print(downloadUrl);
      }
      // }
    } catch (e) {
      throw ('Error getting url');
    }
  }
}
