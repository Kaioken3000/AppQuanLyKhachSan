import 'package:dio/dio.dart';

final Dio _dio = Dio();

Future<dynamic> capnhatdiem(Map<String, dynamic>? data) async {
  try {
    Response response = await _dio.post(
        'https://glorious-basically-molly.ngrok-free.app/mobile/game/capnhatdiem',
        data: {
          'diem': data!['diem'],
          'khachhangid': data['khachhangid'],
        },
        options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
    return {"Message": response.statusCode, "user": response.data};
  } on DioException catch (e) {
    return e.response!.data;
  }
}

Future<dynamic> trudiem(Map<String, dynamic>? data) async {
  try {
    Response response = await _dio.post(
        'https://glorious-basically-molly.ngrok-free.app/mobile/game/trudiem',
        data: {
          'diem': data!['diem'],
          'khachhangid': data['khachhangid'],
        },
        options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
    return {"Message": response.statusCode, "user": response.data};
  } on DioException catch (e) {
    return e.response!.data;
  }
}
