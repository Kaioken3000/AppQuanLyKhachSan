import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/phong_modal.dart';

Future<List<Phongs>> fetchPhongs(http.Client client) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https(
      'glorious-basically-molly.ngrok-free.app', 'mobile/client/index');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parsePhongs in a separate isolate.
  return compute(parsePhongs, response.body);
}

Future<Phongs> fetchPhongWithSoPhong(soPhong) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https('glorious-basically-molly.ngrok-free.app',
      'mobile/client/soPhong/$soPhong');
  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Phongs.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

Future<List<Phongs>> fetchPhongsWithFilter(
    http.Client client, ngayvao, ngayra, soluong) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https('glorious-basically-molly.ngrok-free.app',
      'mobile/client/kiemtraphongtrong/ngaydat=$ngayvao/ngaytra=$ngayra/soluong=$soluong');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parsePhongs in a separate isolate.
  return compute(parsePhongs, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Phongs> parsePhongs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Phongs>((json) => Phongs.fromJson(json)).toList();
}
