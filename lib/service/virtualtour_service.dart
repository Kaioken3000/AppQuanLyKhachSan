import '../modal/virtualtour_modal.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Virtualtour> getVirtualtourByPhongId(soPhong) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https('glorious-basically-molly.ngrok-free.app',
      'mobile/client/virtualtourByPhongId/$soPhong');
  final response = await http.get(uri, headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Virtualtour.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
