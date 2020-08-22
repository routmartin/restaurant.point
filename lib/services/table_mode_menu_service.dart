import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/menu.dart';

import 'package:pointrestaurant/utilities/path.dart';

List<Menu> parseDataMenu(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
}

Future<List<Menu>> fetchMenuSevice() async {
  var dio = Dio();
  Response response = await dio.post(
    serverIP + '/api/ListMenu',
    data: {"userToken": 'zYa7sLhZ+viAYIjJ4PEX7Q=='},
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    print(response.data);
    return parseDataMenu(response.data);
  }
  return null;
}
