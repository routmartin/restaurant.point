import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

Future deleteItems({
  int saleMasterId,
  int saleDetailId,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/DeleteItemOrder',
    data: {
      "userToken": userToken,
      "sale_detail_id": saleDetailId.toString(),
      "sale_master_id": saleMasterId.toString(),
    },
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );
  if (response.statusCode == 200 && response.data != "[]") {
    print("data response: " + response.data);
    return response.data;
  }
  return null;
}
