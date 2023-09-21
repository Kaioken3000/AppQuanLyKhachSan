import 'package:dio/dio.dart';

class DatphongService {
  final Dio _dio = Dio();

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
          'https://glorious-basically-molly.ngrok-free.app/mobile/client/login',
          data: {
            'username': email,
            'password': password,
          },
          options: Options(headers: {'ngrok-skip-browser-warning': '1'})
          // queryParameters: {'apikey': ApiSecret.apiKey},
          );
      return {"Message": response.statusCode, "user": response.data};
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
