import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/list_sale_data.dart';

import 'package:pointrestaurant/utilities/path.dart';
import '../../utilities/globals.dart';

Dio dio = Dio();

List<ListSaleData> parseListSaleData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ListSaleData>((json) => ListSaleData.fromJson(json))
      .toList();
}

Future<List<ListSaleData>> fetchlistSaleSummary({
  sale_from_date,
  sale_to_date,
  sale_customer_chip,
}) async {
  Response response = await dio.post(
    serverIP + '/api/ListSaleData',
    data: {
      "userToken": userToken,
      "sale_from_date": sale_from_date,
      "sale_to_date": sale_to_date,
      "sale_customer_chip": sale_customer_chip,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return parseListSaleData(response.data);
  }
  return null;
}
