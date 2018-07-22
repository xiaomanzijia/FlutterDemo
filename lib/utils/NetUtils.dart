import 'package:http/http.dart' as http;

class NetUtils {
  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramsStr = sb.toString();
      paramsStr = paramsStr.substring(0, paramsStr.length - 1);
      url += paramsStr;
    }
    try {
      http.Response res = await http.get(url);
      if (callback != null) {
        callback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }
}
