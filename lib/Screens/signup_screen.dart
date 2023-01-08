import 'package:car_project/Controllers/signup_controller.dart';
import 'package:car_project/Model/user_model.dart';
import 'package:car_project/Services/car_service.dart';
import 'package:car_project/Services/users_service.dart';
import 'package:car_project/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Constants/constants.dart';
import '../widgets/custom_textField.dart';

class SignUpScreen extends StatelessWidget {
  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: signUpController.formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      'SignUp',
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
                        return input.isValidEmail()
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: signUpController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                    ),
                    CustomSize(),
                    CustomTextField(
                      obscureText: signUpController.passwordHide.value,
                      suffix: GestureDetector(
                        onTap: () {
                          signUpController.passwordHide.value =
                              !signUpController.passwordHide.value;
                        },
                        child: Icon(
                          signUpController.passwordHide.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                      ),
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return input.isValidPassword()
                            ? null
                            : "Password should contain upper,lower,digit and special character";
                      },
                      controller: signUpController.passwordController,
                      keyboardType: TextInputType.text,
                      hintText: 'Password',
                    ),
                    CustomSize(),
                    CustomTextField(
                      obscureText: signUpController.confirmPasswordHide.value,
                      suffix: GestureDetector(
                        onTap: () {
                          signUpController.confirmPasswordHide.value =
                              !signUpController.confirmPasswordHide.value;
                        },
                        child: Icon(
                          signUpController.confirmPasswordHide.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                      ),
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please Re_Enter Password';
                        } else if (input != signUpController.passwordController.text) {
                          return 'Password Not Match';
                        }
                        return null;
                      },
                      controller: signUpController.confirmPasswordController,
                      keyboardType: TextInputType.text,
                      hintText: 'Confirm Password',
                    ),
                    CustomSize(),
                    signUpController.isLoading.value == false
                        ? ReuseableButton(
                            buttontext: 'SignUp',
                            onpress: () {
                              if (signUpController.formKey.currentState!
                                  .validate()) {
                                signUpController.isLoading.value = true;
                                var uuid = Uuid();
                                var id = uuid.v4();
                                UserModel userModel = UserModel(
                                  id: id.toString(),
                                  email: signUpController.emailController.text,
                                  password:
                                      signUpController.passwordController.text,
                                );
                                UserService().addUser(userModel);
                                Future.delayed(Duration(seconds: 7), () {
                                  signUpController.isLoading.value = false;
                                });
                              }
                            },
                          )
                        : const Center(
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
