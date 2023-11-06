import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/anuong_modal.dart';

final Dio _dio = Dio();

Future<dynamic> anuongDatphongStore(Map<String, dynamic>? data) async {
  try {
    Response response = await _dio.post(
        'https://glorious-basically-molly.ngrok-free.app/mobile/client/anuong_datphong_store',
        data: {
          'datphongid': data!['datphongid'],
          'khachhangid': data['khachhangid'],
          'anuongid': data['anuongid'],
          'soluong': data['soluong'],
        },
        options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
    return {"Message": response.statusCode, "user": response.data};
  } on DioException catch (e) {
    return e.response!.data;
  }
}

Future<List<Anuongs>> fetchAnuongs(http.Client client) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https(
      'glorious-basically-molly.ngrok-free.app', 'mobile/client/anuongAll');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parseAnuongs in a separate isolate.
  return compute(parseAnuongs, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Anuongs> parseAnuongs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Anuongs>((json) => Anuongs.fromJson(json)).toList();
}
