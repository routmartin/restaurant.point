import 'package:dio/dio.dart';

import 'package:pointrestaurant/utilities/path.dart';

var dio = Dio();
Future addOrderItems(
    {int itemDetailId,
    saleMasterId,
    int qty,
    int saleDetailId,
    int tableId}) async {
  Response response = await dio.post(serverIP + '/Api/OrderItem',
      data: {
        "userToken": userToken,
        "item_detail_id": itemDetailId,
        "sale_master_id": saleMasterId,
        "tableId": tableId,
        "qty": qty,
        "sale_detail_id": saleDetailId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType));
  if (response.statusCode == 200 && response.data != "[]") {
    print(response);
  }
  return null;
}
