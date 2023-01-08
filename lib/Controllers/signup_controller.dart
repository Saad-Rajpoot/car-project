import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool passwordHide = true.obs;
  RxBool confirmPasswordHide = true.obs;
  RxBool isLoading = false.obs;
}