import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/chinhanh_modal.dart';

Future<List<Chinhanhs>> fetchChinhanhs(http.Client client) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https(
      'glorious-basically-molly.ngrok-free.app', 'mobile/client/chinhanhAll');
  final response = await client.get(uri, headers: header);
  // Use the compute function to run parseChinhanhs in a separate isolate.
  print(response.body);
  return compute(parseChinhanhs, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Chinhanhs> parseChinhanhs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Chinhanhs>((json) => Chinhanhs.fromJson(json)).toList();
}
