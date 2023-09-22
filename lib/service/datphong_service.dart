import 'package:dio/dio.dart';

import '../modal/user_modal.dart';

class DatphongService {
  final Dio _dio = Dio();

  Future<dynamic> thanhtoan(String ngaydat, String ngaytra, int soluong,
      int phongid, int sotien, String stripeToken, Users user) async {
    try {
      Response response = await _dio.post(
          'https://glorious-basically-molly.ngrok-free.app/mobile/client/datphong',
          data: {
            'ten': user.username,
            'sdt': user.khachhangs![0].sdt,
            'email': user.email,
            'diachi': user.khachhangs![0].diachi,
            'vanbang': user.khachhangs![0].vanbang,
            'ngaydat': ngaydat,
            'ngaytra': ngaytra,
            'soluong': soluong,
            'phongid': phongid,
            'tinhtrangthanhtoan': '0',
            'tinhtrangnhanphong': '0',
            'tinhtrangxuly': '0',
            'huydatphong': '0',
            'khachhangid': user.id,
            'sotien': sotien/2,
            'stripeToken': stripeToken,
          },
          options: Options(headers: {'ngrok-skip-browser-warning': '1'})
          // queryParameters: {'apikey': ApiSecret.apiKey},
          );
      return {"Message": response.statusCode, "data": response.data};
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
