import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/loaiphong_modal.dart';

Future<List<Loaiphongs>> fetchLoaiphongs(http.Client client) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https(
      'glorious-basically-molly.ngrok-free.app', 'mobile/client/loaiphongAll');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parseLoaiphongs in a separate isolate.
  print(response.body);
  return compute(parseLoaiphongs, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Loaiphongs> parseLoaiphongs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Loaiphongs>((json) => Loaiphongs.fromJson(json)).toList();
}
