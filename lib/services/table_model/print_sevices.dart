import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';
import '../../utilities/globals.dart';

Dio dio = Dio();

Future printtoKitchen({
  int sale_detail_ids = 0,
  int sale_master_id,
  String table_name,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/PrintOrder',
    data: {
      "userToken": userToken,
      "master_id": sale_master_id,
      "sale_detail_ids": sale_detail_ids,
      "table_name": table_name,
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

Future printBill({
  int sale_master_id,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/PrintBill',
    data: {
      "userToken": userToken,
      "master_id": sale_master_id,
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

Future printBillWithM1({
  int sale_master_id,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/PrintBillInternal',
    data: {
      "userToken": userToken,
      "master_id": sale_master_id,
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.bytes,
    ),
  );
  if (response.statusCode == 200 && response.data != "[]") {
    print(response.data);
    return response.data;
  }
  return null;
}

Future paymentInCash({
  int sale_master_id,
  int rate_kh_id,
  int rate_us_id,
  int exchange_rate_kh,
  int exchange_rate_us,
  int amount_kh,
  int amount_us,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/PayInCash',
    data: {
      "userToken": userToken,
      "sale_master_id": sale_master_id,
      "rate_kh_id": rate_kh_id,
      "rate_us_id": rate_us_id,
      "exchange_rate_kh": exchange_rate_kh,
      "exchange_rate_us": exchange_rate_us,
      "amount_kh": amount_kh,
      "amount_us": amount_us,
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

Future payInternalPrint({
  int sale_master_id,
  int rate_kh_id,
  int rate_us_id,
  int exchange_rate_kh,
  int exchange_rate_us,
  int amount_kh,
  int amount_us,
  int return_kh,
  double return_us,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/PayInternalPrint',
    data: {
      "userToken": userToken,
      "sale_master_id": sale_master_id,
      "rate_kh_id": rate_kh_id,
      "rate_us_id": rate_us_id,
      "exchange_rate_kh": exchange_rate_kh,
      "exchange_rate_us": exchange_rate_us,
      "amount_kh": amount_kh,
      "amount_us": amount_us,
      "return_kh": return_kh,
      "return_us": return_us,
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
