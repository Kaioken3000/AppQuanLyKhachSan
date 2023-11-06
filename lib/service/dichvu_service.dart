import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/dichvu_modal.dart';

final Dio _dio = Dio();

Future<dynamic> dichvuDatphongStore(Map<String, dynamic>? data) async {
  try {
    Response response = await _dio.post(
        'https://glorious-basically-molly.ngrok-free.app/mobile/client/dichvu_datphong_store',
        data: {
          'dichvuid': data!['dichvuid'],
          'datphongid': data['datphongid'],
          'khachhangid': data['khachhangid'],
        },
        options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
    return {"Message": response.statusCode, "user": response.data};
  } on DioException catch (e) {
    return e.response!.data;
  }
}

Future<List<Dichvus>> fetchDichvus(http.Client client) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https(
      'glorious-basically-molly.ngrok-free.app', 'mobile/client/dichvuAll');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parseDichvus in a separate isolate.
  return compute(parseDichvus, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Dichvus> parseDichvus(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Dichvus>((json) => Dichvus.fromJson(json)).toList();
}
