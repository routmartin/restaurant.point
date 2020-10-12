import 'package:dio/dio.dart';
// import 'package:pointrestaurant/utilities/path.dart';
import '../utilities/globals.dart' as globals;

Dio dio = Dio();
Future logInSubmit(String company, String userName, String passWord) async {
  String serverIP = 'http://${globals.ipAddress}:${globals.port}';
  String query = serverIP + "/Api/Login";
  Response response = await dio.post(
    query,
    data: {"company": company, "userName": userName, "pwd": passWord},
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return response.data;
  }
  return null;
}
