abstract class ApiHandler {
  Future<dynamic> get(String? url,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {}
  Future<dynamic> post(String? url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {}

  Future<dynamic> put(String? url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {}
  Future<dynamic> delete(String? url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {}
}
