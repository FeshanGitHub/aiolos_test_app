import 'dart:convert';
import 'package:aiolos/presentation/home/controller/home_screen_controller.dart';
import 'package:aiolos/presentation/home/view/home_screen.dart';
import 'package:aiolos/presentation/login/model/login_error_model.dart';
import 'package:aiolos/presentation/login/model/login_success_model.dart';
import 'package:aiolos/presentation/resources/routes_manager.dart';
import 'package:aiolos/utils/crud/user_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isProcess = false.obs;

  Future login() async {
    isProcess.value = true;
    final response =
        await http.post(Uri.parse("https://stage.getsetplay.co/api/login.php"),
            headers: {
              "Content-Type": "application/json",
            },
            body: json.encode({
              "username": usernameController.text.trim(),
              "password": passwordController.text.trim(),
            }));
    try {
      if (response.statusCode == 200) {
        var detail = json.decode(response.body);
        var data = LoginSuccessResponse.fromJson(detail);
        setToken(data.data.token);
        Get.offAllNamed(RoutesManager.homeRoute);
        isProcess.value = false;
      } else if (response.statusCode == 400) {
        var detail = json.decode(response.body);
        var data = LoginErrorResponse.fromJson(detail);
        Fluttertoast.showToast(
            msg: data.message, toastLength: Toast.LENGTH_LONG);
        isProcess.value = false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
