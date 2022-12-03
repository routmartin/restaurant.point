import 'package:dio/dio.dart';
import '../../utilities/globals.dart';

String serverIP = 'http://$ipAddress:$port';
Dio dio = Dio();

Future applyPercentDisItem({
  String dis_percent_item,
  int saleDetailId,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/DisItemPercent',
    data: {
      "userToken": userToken,
      "sale_detail_id": saleDetailId,
      "dis_percent_item": dis_percent_item,
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

Future applyPercentDollItem({
  String dis_cash_item,
  int saleDetailId,
}) async {
  print("dis_percent_item: " + dis_cash_item);
  print("saleDetailId: " + saleDetailId.toString());
  Response response = await dio.post(
    serverIP + '/Api/DisItemDollar',
    data: {
      "userToken": userToken,
      "sale_detail_id": saleDetailId,
      "dis_cash_item": dis_cash_item,
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

Future applyDiscountCashonInvoice({
  String dis_cash_inv,
  int sale_master_id,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/DisInvDollar',
    data: {
      "userToken": userToken,
      "sale_master_id": sale_master_id,
      "dis_cash_inv": dis_cash_inv,
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

Future applyDiscountPercentonInvoice({
  String dis_percent_inv,
  int sale_master_id,
}) async {
  Response response = await dio.post(
    serverIP + '/Api/DisInvPercent',
    data: {
      "userToken": userToken,
      "sale_master_id": sale_master_id,
      "dis_percent_inv": dis_percent_inv,
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
