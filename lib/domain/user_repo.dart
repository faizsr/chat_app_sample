import 'package:chat_app_test/core/utils.dart';
import 'package:chat_app_test/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepo {
  static Future<List<UserModel>> fetchUserDetails() async {
    Dio dio = Dio();
    String token = token1;
    String userId = currentUserId;
    String userListUrl = "$baseUrl$allUsers";
    List<UserModel> users = [];
    try {
      var response = await dio.get(
        userListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch User Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        List userList = responseData['user'];
        for (int i = 0; i < userList.length; i++) {
          UserModel user = UserModel.fromJson(userList[i]);
          if (user.id != userId) {
            users.add(user);
          }
        }
        return users;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch User Error: ${e.toString()}');
      return [];
    }
  }
}
