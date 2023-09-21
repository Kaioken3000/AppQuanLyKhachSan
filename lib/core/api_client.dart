import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modal/user_modal.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<dynamic> registerUser(Map<String, dynamic>? data) async {
    try {
      Response response = await _dio.post(
          'https://api.loginradius.com/identity/v2/auth/register',
          data: data,
          // queryParameters: {'apikey': ApiSecret.apiKey},
          options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
          'https://glorious-basically-molly.ngrok-free.app/mobile/client/login',
          data: {
            'username': email,
            'password': password,
          },
          options: Options(headers: {'ngrok-skip-browser-warning': '1'})
          // queryParameters: {'apikey': ApiSecret.apiKey},
          );
      return {"Message": response.statusCode, "user": response.data};
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getUserProfileData(String accessToken) async {
    try {
      Response response =
          await _dio.get('https://api.loginradius.com/identity/v2/auth/account',
              // queryParameters: {'apikey': ApiSecret.apiKey},
              options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response =
          await _dio.put('https://api.loginradius.com/identity/v2/auth/account',
              data: data,
              // queryParameters: {'apikey': ApiSecret.apiKey},
              options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
          'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
          // queryParameters: {'apikey': ApiSecret.apiKey},
          options: Options(headers: {'ngrok-skip-browser-warning': '1'}));
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
