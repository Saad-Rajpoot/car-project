
import 'dart:io';

import 'package:car_project/Model/car_model.dart';
import 'package:car_project/Services/car_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'car_controller.dart';

class AddCarController extends GetxController{
  TextEditingController carName = TextEditingController();
  TextEditingController carModel = TextEditingController();
  TextEditingController carPrice = TextEditingController();
  TextEditingController carRegNo = TextEditingController();
  RxList<File> addCarImageList = RxList<File>([]);
  List<String> companies = ['Toyota', 'Honda', 'Yamaha', 'Kia'];
  var selectedCompany = 'Toyota'.obs;
  void setSelected(String value){
    selectedCompany.value = value;
  }
  Rx<Color> myColor = Colors.blue.obs;
  RxBool isLoading = RxBool(false);
  final formKey = GlobalKey<FormState>();

  AddCar()  async {
    try {
      isLoading.value = true;
      CarModel mainCarModel = CarModel(name: carName.text, model: carModel.text, company: selectedCompany.value.toString(), reg_no: carRegNo.text, color: myColor.value.toString(), price: int.parse(carPrice.text), image: addCarImageList.last.path.toString());
     /// add data to database
      await CarService().insert(mainCarModel);
      /// fetch data
      Get.find<CarController>().fetchCars();
    } finally {
      Future.delayed(Duration(seconds: 5), (){
        Get.back();
        isLoading.value = false;
      });

    }
  }
}