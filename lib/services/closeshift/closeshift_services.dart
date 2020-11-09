import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';
import '../../utilities/globals.dart';

Dio dio = Dio();

Future cashRegistration() async {
  print(userToken);
  Response response = await dio.post(
    serverIP + '/Api/CashRegistration',
    data: {
      "userToken": userToken,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return jsonDecode(response.data);
  }
  return null;
}

Future cashIn(
    {cashRegisterId = '',
    cashOne = '',
    cashTwo = '',
    cashInKHR,
    cashInUSD}) async {
  print(cashInKHR + '&&' + cashInUSD);
  Response response = await dio.post(
    serverIP + '/Api/CashIn',
    data: {
      "userToken": userToken,
      "cash_register_id": cashRegisterId,
      "rate_us_id": '1',
      "rate_kh_id": '2',
      "cash_detail_id": [cashOne, cashTwo],
      "cashin_amount_kh": cashInKHR,
      "cashin_amount_us": cashInUSD,
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
