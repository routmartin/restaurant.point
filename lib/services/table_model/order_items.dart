import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

Future addOrderItems({
  int itemDetailId,
  int saleMasterId,
  int saleDetailId,
  int tableId,
  int qty,
}) async {
  // print(itemDetailId);
  // print(saleMasterId);
  // print(saleDetailId);
  // print(tableId);
  // print(qty);

  Response response = await dio.post(
    serverIP + '/Api/OrderItem',
    data: {
      "userToken": userToken,
      "item_detail_id": itemDetailId.toString(),
      "sale_master_id": saleMasterId.toString(),
      "table_id": tableId.toString(),
      "qty": qty,
      "sale_detail_id": saleDetailId,
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
