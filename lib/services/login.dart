import 'package:dio/dio.dart';
import 'package:pointrestaurant/utilities/path.dart';

Future logInSubmit(String company, String userName, String passWord) async {
  print(serverIP);
  Dio dio = Dio();
  Response response = await dio.post(
    serverIP + '/Api/Login',
    data: {"company": company, "userName": userName, "pwd": passWord},
    options: Options(contentType: Headers.formUrlEncodedContentType),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    return response.data;
  }
  return null;
}
