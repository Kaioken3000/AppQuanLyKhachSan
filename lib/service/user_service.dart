import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modal/user_modal.dart';

Future<Users> getUserById(userid) async {
  Map<String, String> header = {
    'ngrok-skip-browser-warning': '1',
  };
  var uri = Uri.https(
      'glorious-basically-molly.ngrok-free.app', 'mobile/client/getUserById/$userid');
  final response = await http
      .get(uri, headers: header);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Users.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
