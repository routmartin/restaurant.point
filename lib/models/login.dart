import 'package:dio/dio.dart';

import 'constant.dart';

Future logInSubmit(String userName, String passWord) async {
  var dio = Dio();
  Response response = await dio.post(
    server + '/Api/Login',
    data: {"userName": userName, "pwd": passWord},
    options: Options(contentType: Headers.formUrlEncodedContentType),
  );

  if (response.statusCode == 200 && response.data != "[]") {
    print("Data From API: " + response.data);
    return response.data;
  }
  return null;
}
