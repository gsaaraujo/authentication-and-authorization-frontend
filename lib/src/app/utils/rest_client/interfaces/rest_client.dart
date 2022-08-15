abstract class IRestClient {
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  });

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? headers,
  });

  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
  });

  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, dynamic>? headers,
  });
}
