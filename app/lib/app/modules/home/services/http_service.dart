import 'package:dio/dio.dart';

import 'interfaces/ihttp_service.dart';

class HttpService implements IHttpService {
  static const _url = "http://192.168.0.109:8000/"; // Casa
  // static const _url = "http://192.168.80.166:8000/"; // Cel

  final Dio _dio = Dio(
    BaseOptions(
      // http://192.168.0.109:5000/  --> Endereço do Note
      persistentConnection: true,
      connectTimeout: const Duration(minutes: 1),
      contentType: 'application/json',
      followRedirects: false,
      validateStatus: (status) => true,
    ),
  );

  @override
  Future<dynamic> get({
    required String endpoint,
  }) async {
    final response = await _dio.get(endpoint);

    return response.data;
  }

  @override
  Future post({
    required String endpoint,
    required Object data,
  }) async {
    final response = await _dio.post(
      '$_url$endpoint',
      data: data,
    );

    return response.data;
  }
}
