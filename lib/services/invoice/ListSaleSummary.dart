import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/List_sale_ummary.dart';

import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

List<ListSaleSummary> parseListSaleSummery(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ListSaleSummary>((json) => ListSaleSummary.fromJson(json))
      .toList();
}

Future<List<ListSaleSummary>> fetchlistSaleSummary({
  sale_from_date = '',
  sale_to_date = '',
  sale_customer_chip = '',
}) async {
  Response response = await dio.post(
    serverIP + '/api/ListSaleSummary',
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
    return parseListSaleSummery(response.data);
  }
  return null;
}
