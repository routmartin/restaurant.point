import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/move_list.dart';
import 'package:pointrestaurant/utilities/path.dart';
import '../../utilities/globals.dart';

Dio dio = Dio();

List<MoveList> parseMoveList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<MoveList>((json) => MoveList.fromJson(json)).toList();
}

Future<List<MoveList>> fetchMoveList({tableId}) async {
  Response response = await dio.post(serverIP + '/api/ListAvailableMove',
      data: {
        "userToken": userToken,
        "table_id": tableId,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ));
  if (response.statusCode == 200 && response.data != "[]") {
    return parseMoveList(response.data);
  }
  return null;
}

Future requestPermissionToMove() async {
  Response response = await dio.post(
    serverIP + '/Api/getPermissionMoveTable',
    data: {
      "userToken": userToken,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    print(response.data);
    return response.data;
  }
  return null;
}

Future requestAuthorizationMoveTable(
    {String userName, String passWord, int saleMasterId, int tableId}) async {
  Response response = await dio.post(
    serverIP + '/Api/authorizeMoveTable',
    data: {
      "userName": userName,
      "pwd": passWord,
      "passWord": saleMasterId,
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

Future movetoTable({
  int saleMasterId,
  int tableId,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/MoveTable',
    data: {
      "userToken": userToken,
      "sale_master_id": saleMasterId,
      "table_id": tableId,
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
