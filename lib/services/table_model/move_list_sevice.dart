import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/move_list.dart';

import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

List<MoveList> parseMoveList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<MoveList>((json) => MoveList.fromJson(json)).toList();
}

Future<List<MoveList>> fetchMoveList() async {
  Response response = await dio.post(serverIP + '/api/ListAvailableMove',
      data: {"userToken": userToken},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ));
  if (response.statusCode == 200 && response.data != "[]") {
    return parseMoveList(response.data);
  }
  return null;
}
