import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/floor.dart';
import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

List<Floor> parseDataFloor(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Floor>((json) => Floor.fromJson(json)).toList();
}

Future<List<Floor>> fetchDataFloors() async {
  Response response = await dio.post(
    serverIP + '/api/TableLayout',
    data: {
      "userToken": userToken,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return parseDataFloor(response.data);
  }
  return null;
}
