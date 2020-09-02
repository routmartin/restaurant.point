import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';

Dio dio = Dio();

Future deleteItems({
  int saleMasterId,
  int saleDetailId,
}) async {
  print("saleDetailId_: " + saleDetailId.toString());
  print("saleMasterId_: " + saleMasterId.toString());

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

Future overideDeleteItems({
  int saleMasterId,
  int saleDetailId,
  String username,
  String password,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/promptUserDeleteItem',
    data: {
      "userName": username,
      "pwd": password,
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
