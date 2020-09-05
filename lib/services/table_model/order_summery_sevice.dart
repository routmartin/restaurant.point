import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/ordersummery.dart';
import 'package:pointrestaurant/utilities/path.dart';

List<Ordersummery> parseOrderSummery(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<Ordersummery>((json) => Ordersummery.fromJson(json))
      .toList();
}

Dio dio = Dio();
Future<List<Ordersummery>> fetchOrderSummery({
  int sale_master_id,
  int table_id,
}) async {
  print(sale_master_id);
  Response response = await dio.post(
    serverIP + '/api/OrderSummary',
    data: {
      "userToken": userToken,
      "sale_master_id": sale_master_id,
      "table_id": table_id,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return parseOrderSummery(response.data);
  }
  return null;
}
