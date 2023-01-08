
import 'dart:io';

import 'package:car_project/Controllers/car_controller.dart';
import 'package:car_project/Model/car_model.dart';
import 'package:car_project/Services/car_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCarController extends GetxController{
  final carController = Get.find<CarController>();
  TextEditingController editCarName = TextEditingController();
  TextEditingController editCarModel = TextEditingController();
  TextEditingController editCarPrice = TextEditingController();
  TextEditingController editCarRegNo = TextEditingController();
  RxString carImage = "".obs;
  RxList<File> editCarImageList = RxList<File>([]);
  List<String> companies = ['Toyota', 'Honda', 'Yamaha', 'Kia'];
  var selectedCompany = 'Toyota'.obs;
  Rx<Color> myColor = Color(0XFFffffff).obs;
  RxBool isLoading = RxBool(false);
  final formKey = GlobalKey<FormState>();


  @override
  onInit() {
    super.onInit();
    ///first call this function when screen open then all the data passes to the variables

    /// convert string to color
    String valueString = carController.carModel.value.color.split('(0x')[1]
        .split(')')[0].toString();
    int value = int.parse(valueString, radix: 16);
    Color carColor = Color(value);
    /// end

    /// pass data to these variables
    carImage.value = carController.carModel.value.image;
    editCarName.text = carController.carModel.value.name;
    selectedCompany.value = carController.carModel.value.company;
    editCarModel.text = carController.carModel.value.model;
    editCarPrice.text = carController.carModel.value.price.toString();
    editCarRegNo.text = carController.carModel.value.reg_no;

    myColor.value = carColor;
  }

  void setSelected(String value){
    /// drop down selected company
    selectedCompany.value = value;
  }

  EditCar(int? id) async {
    try {
      if(id != null) {
        isLoading.value = true;
        CarModel mainCarModel = CarModel(
            image: editCarImageList.isEmpty ? carImage.value.toString() : editCarImageList.last.path.toString(),
            name: editCarName.text,
            model: editCarModel.text,
            company: selectedCompany.value,
            reg_no: editCarRegNo.text,
            color: myColor.value.toString(),
            price: int.parse(editCarPrice.text));
        /// update function call of database
        await CarService().update(mainCarModel, id);
        /// fetch users data if changes
        Get.find<CarController>().fetchCars();
      }
    } finally {
      /// for some delay back to previous screen
      Future.delayed(Duration(seconds: 5), (){
        Get.back();
        isLoading.value = false;

      });
    }
  }
}