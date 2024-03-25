import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/auth_utility.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),
          headers: {'token': AuthUtility.userInfo.token.toString()});

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'token': AuthUtility.userInfo.token.toString()
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        gotoLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<void> gotoLogin() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
