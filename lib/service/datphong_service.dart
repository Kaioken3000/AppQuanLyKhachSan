import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../modal/datphong_modal.dart';
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
            'sotien': sotien / 2,
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

Future<List<Datphongs>> getDatphongByKhachhangid(
    http.Client client, khachhangid) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https('glorious-basically-molly.ngrok-free.app',
      'mobile/client/getDatphongByKhachhangid/$khachhangid');
  final response = await client.get(uri, headers: header);

  // Use the compute function to run parseDatphongs in a separate isolate.
  return compute(parseDatphongs, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Datphongs> parseDatphongs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Datphongs>((json) => Datphongs.fromJson(json)).toList();
}
