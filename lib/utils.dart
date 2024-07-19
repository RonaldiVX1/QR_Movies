import 'package:dio/dio.dart';

class NetworkingUtil {
  static Map<String, dynamic> setupTokenHeader(String? withToken) {
    final headers = <String, dynamic>{
      if (withToken != null) 'Authorization': withToken,
      'Accept': 'application/json',
    };
    return headers;
  }

  static Options setupNetworkOptions(String? withToken,
      {Options? otherOptions}) {
    if (otherOptions != null) {
      otherOptions.headers = setupTokenHeader(withToken);
      return otherOptions;
    } else {
      return Options(
          contentType: 'application/json',
          headers: setupTokenHeader(withToken));
    }
  }
}
