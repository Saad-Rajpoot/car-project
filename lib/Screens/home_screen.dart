import 'package:car_project/Controllers/car_controller.dart';
import 'package:car_project/Model/car_model.dart';
import 'package:car_project/Screens/add_car_screen.dart';
import 'package:car_project/widgets/car_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/bindings.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Car Lists',
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GetX<CarController>(builder: (exploreController) {
            if (exploreController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: exploreController.carLists.length,
                itemBuilder: (context, index) {
                  CarModel car = exploreController.carLists[index];
                  return CarWidget(car, exploreController);
                });
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCarScreen(), binding: HomeBinding());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
