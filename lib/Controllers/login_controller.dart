import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool obscureText = true.obs;
  RxBool isLoading = false.obs;
}