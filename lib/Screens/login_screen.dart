import 'package:car_project/Services/car_service.dart';
import 'package:car_project/Constants/constants.dart';
import 'package:car_project/Services/users_service.dart';
import 'package:car_project/widgets/custom_textField.dart';
import 'package:car_project/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: loginController.formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 43),
                    const Text(
                      'Please enter your phone number to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    CustomSize(),
                    CustomTextField(
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return input.isValidEmail() ? null : "Please Enter Correct Email";
                      },
                      controller: loginController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                    ),
                    CustomSize(),
                    CustomTextField(
                      obscureText: loginController.obscureText.value,
                      suffix: InkWell(
                        onTap: (){
                          loginController.obscureText.value = !loginController.obscureText.value;
                        },
                        child: Icon(loginController.obscureText.value ? Icons.visibility : Icons.visibility_off, color: Colors.blue,),
                      ),
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return input.isValidPassword()
                            ? null
                            : "Please Enter Correct Password";
                      },
                      controller: loginController.passwordController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Password',
                    ),
                    CustomSize(),
                    loginController.isLoading.value == false
                        ? ReuseableButton(
                      buttontext: 'Login',
                      onpress: () {
                        if (loginController.formKey.currentState!
                            .validate()) {
                          loginController.isLoading.value = true;
                          UserService().loginUser(loginController.emailController.text);
                          Future.delayed(Duration(seconds: 5), (){
                            loginController.isLoading.value = false;
                          });
                        }
                      },
                    ) : const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
