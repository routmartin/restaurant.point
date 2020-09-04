import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

Future printtoKitchen({
  int sale_detail_ids = 0,
  int sale_master_id,
  String table_name,
}) async {
  print('call print func...');
  print('sale_detail_idsL ' + sale_detail_ids.toString());
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
    return response.data;
  }
  return null;
}
