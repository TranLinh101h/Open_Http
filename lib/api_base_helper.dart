import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//process response data
dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      return responseJson;
    case 400:
      return {
        "response": response,
        "error":
            "Error occured while Communication with Server with StatusCode : ${response.statusCode}"
      };
    case 401:
      return {
        "response": response,
        "error":
            "Error occured while Communication with Server with StatusCode : ${response.statusCode}"
      };
    case 403:
      return {
        "response": response,
        "error":
            "Error occured while Communication with Server with StatusCode : ${response.statusCode}"
      };
    case 404:
      return {
        "response": response,
        "error":
            "Error occured while Communication with Server with StatusCode : ${response.statusCode}"
      };
    case 500:
      return {
        "response": response,
        "error":
            "Error occured while Communication with Server with StatusCode : ${response.statusCode}"
      };
    default:
      return {
        "response": response,
        "error": "${response.body} : ${response.statusCode}"
      };
  }
}

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));

      responseJson = _returnResponse(response);
    } on SocketException catch (e) {
      return {"error": e.message};
    }

    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(body));

      responseJson = _returnResponse(response);
    } on SocketException catch (e) {
      return {"error": e.message};
    }

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      return {"error": "no_interet"};
    }

    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    dynamic apiResponse;
    try {
      final response = await http.delete(Uri.parse(url));
      apiResponse = _returnResponse(response);
    } on SocketException catch (e) {
      return {"error": e.message};
    }

    return apiResponse;
  }
}
