import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/menu.dart';

import 'package:pointrestaurant/utilities/path.dart';

List<Menu> parseDataMenu(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
}

Future<List<Menu>> fetchMenuSevice({int saleMasterId}) async {
  var dio = Dio();
  Response response = await dio.post(
    serverIP + '/api/ListItem',
    data: {
      "userToken": userToken,
      "sale_master_id": saleMasterId,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return parseDataMenu(response.data);
  }
  return null;
}
