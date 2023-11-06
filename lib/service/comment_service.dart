import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/comment_modal.dart';

class CommentService {
  final Dio _dio = Dio();

  Future<dynamic> storeComment(
      String noidung, String userid, String phongid) async {
    try {
      Response response = await _dio.post(
          'https://glorious-basically-molly.ngrok-free.app/mobile/client/storeComment',
          data: {
            'noidung': noidung,
            'userid': userid,
            'phongid': phongid,
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

Future<List<Comments>> fetchCommentsWithSoPhong(
    http.Client client, soPhong) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https('glorious-basically-molly.ngrok-free.app',
      'mobile/client/getComment/$soPhong');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parseComments in a separate isolate.
  return compute(parseComments, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Comments> parseComments(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Comments>((json) => Comments.fromJson(json)).toList();
}
