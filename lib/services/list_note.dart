import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/note.dart';
import 'package:pointrestaurant/utilities/path.dart';

List<Note> parseListNote(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Note>((json) => Note.fromJson(json)).toList();
}

Future<List<Note>> fetchListNote({int saleMasterId}) async {
  var dio = Dio();
  Response response = await dio.post(
    serverIP + '/api/ListItemNote',
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return parseListNote(response.data);
  }
  return null;
}
