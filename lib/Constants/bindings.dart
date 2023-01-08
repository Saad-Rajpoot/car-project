import 'package:car_project/Controllers/add_car_controller.dart';
import 'package:car_project/Controllers/car_controller.dart';
import 'package:car_project/Controllers/edit_car_controller.dart';
import 'package:car_project/Controllers/login_controller.dart';
import 'package:car_project/Controllers/signup_controller.dart';
import 'package:car_project/Model/car_model.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarController>(() => CarController());
    Get.lazyPut<AddCarController>(() => AddCarController());
    Get.lazyPut<EditCarController>(() => EditCarController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}