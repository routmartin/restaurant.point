import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/note.dart';
import 'package:pointrestaurant/utilities/path.dart';
import '../utilities/globals.dart' as globals;

Dio dio = Dio();

List<Note> parseListNote(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Note>((json) => Note.fromJson(json)).toList();
}

Future<List<Note>> fetchListNote({int saleMasterId}) async {
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

Future applySpecialRequest({
  List noteList,
  int saleMasterId,
  int saleDetailId,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/AddNote',
    data: {
      "userToken": globals.userToken,
      "note_id": noteList.join(','),
      "sale_detail_id": saleDetailId.toString(),
      "sale_master_id": saleMasterId.toString(),
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );
  if (response.statusCode == 200 && response.data != "[]") {
    return response.data;
  }
  return null;
}
