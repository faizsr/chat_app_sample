import 'package:chat_app_test/core/utils.dart';
import 'package:chat_app_test/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileRepo {
  static Future<UserModel?> fetchUserDetails() async {
    var dio = Dio();
    String token = token1;
    String userDetailUrl = "$baseUrl$currentUser";
    try {
      var response = await dio.get(
        userDetailUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      debugPrint('Fetch Users Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        UserModel user = UserModel.fromJson(responseData['user']);
        return user;
      }
      return null;
    } catch (e) {
      debugPrint('Fetch Users Error: ${e.toString()}');
      return null;
    }
  }
}
