import 'package:car_project/Constants/bindings.dart';
import 'package:car_project/Model/car_model.dart';
import 'package:car_project/Model/user_model.dart';
import 'package:car_project/Services/car_service.dart';
import 'package:car_project/Screens/edit_car_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarController extends GetxController {
  ///Observable List
  var carLists = <CarModel>[].obs;
  var isLoading = true.obs;
  Rx<CarModel> carModel = CarModel(name: '', model: '', company: '', reg_no: '', color: '', price: 0, image: '').obs ;

  @override
  void onInit() {
    super.onInit();
    ///When creating controller then first call this function
    fetchCars();
  }

  fetchCars() async  {
    try {
      isLoading(true);
      ///Get Cars Data
      var cars = await  CarService().getAllSortedByName();
      carLists.value = cars;
    } finally {
      isLoading(false);
    }
    carLists.refresh();
  }

  deleteCar(CarModel carModel) async {
      await  CarService().delete(carModel);
      fetchCars();
  }

  showAlertDialog(BuildContext context, CarModel carModel) {

    /// set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {
        deleteCar(carModel);
        Get.back();
      },
    );

    /// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text("Would you like to delete an item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onEdit(CarModel newCarModel) async {
    ///pass model data to this model data
    carModel.value = newCarModel;
   toEditPage();
  }

  void toEditPage() async {
    ///Navigate next Screen
    Get.to(()=>EditCarScreen(),binding: HomeBinding());
  }
}
