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
    return response.data;
  }
  return null;
}

Future requestToVoidInvoice({
  int saleMasterId,
  String reason,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/GetPermmisionVoidInvoice',
    data: {
      "userToken": userToken,
      "sale_master_id": saleMasterId,
      "reason": reason,
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

Future overideVoidInvice({
  int saleMasterId,
  String username,
  String password,
  String reason = 'no reason',
}) async {
  Response response = await dio.post(
    serverIP + '/Api/OveridePermissionVoiceInvoice',
    data: {
      "userName": username,
      "pwd": password,
      "sale_master_id": saleMasterId,
      "reason": reason,
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
