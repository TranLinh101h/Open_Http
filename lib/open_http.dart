library open_http;

import 'dart:async';
import 'dart:io';
import 'package:open_http/api_base_helper.dart';
export 'package:open_http/api_base_helper.dart';

class OpenHttp {
  static final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  static get({required String path, int timeout = 3000}) async {
    // ignore: avoid_print
    print("URL: $path");
    try {
      final response = await _apiBaseHelper
          .get(path)
          .timeout(Duration(milliseconds: timeout));
      // ignore: avoid_print
      print("URL: $path \n respon: $response");
      return response;
    } on TimeoutException catch (e) {
      // ignore: avoid_print
      print("URL: $path \n respon: ${e.message}");
      return {"error": e.message};
    } on SocketException catch (e) {
      // ignore: avoid_print
      print("URL: $path \n respon: ${e.message}");
      return {"error": e.message};
    }
  }

  static post(
      {required String path, required dynamic body, int timeout = 3000}) async {
    // ignore: avoid_print
    print("URL: $path \n body: $body");
    try {
      final response = await _apiBaseHelper
          .post(path, body)
          .timeout(Duration(milliseconds: timeout));

      // ignore: avoid_print
      print("URL: $path \n respon: $response");
      return response;
    } on TimeoutException catch (e) {
      // ignore: avoid_print
      print("URL: $path \n respon: ${e.message}");
      return {"error": e.message};
    } on SocketException catch (e) {
      // ignore: avoid_print
      print("URL: $path \n respon: ${e.message}");
      return {"error": e.message};
    }
  }
}

//
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        //add your certificate verification logic here
        return true;
      };
  }
}
