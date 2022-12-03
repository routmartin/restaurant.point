import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/models/payment_load.dart';
import 'package:pointrestaurant/utilities/path.dart';
import '../../utilities/globals.dart';

List<PaymentLoad> parsePaymentLoadData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<PaymentLoad>((json) => PaymentLoad.fromJson(json)).toList();
}

Dio dio = Dio();

Future<List<PaymentLoad>> fetchPaymentMethod({int sale_master_id}) async {
  Response response = await dio.post(
    serverIP + '/api/LoadPayment',
    data: {
      "userToken": userToken,
      "sale_master_id": sale_master_id,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return parsePaymentLoadData(response.data);
  }
  return null;
}
