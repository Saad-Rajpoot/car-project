import 'package:car_project/Controllers/add_car_controller.dart';
import 'package:car_project/Constants/constants.dart';
import 'package:car_project/Controllers/image_picker_controller.dart';
import 'package:car_project/widgets/custom_textField.dart';
import 'package:car_project/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../Controllers/car_controller.dart';

class AddCarScreen extends StatelessWidget {
  final addCarController = Get.find<AddCarController>();
  final imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Add Car',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Form(
            key: addCarController.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSize(),
                  /// if image is selected or not
                  addCarController.addCarImageList.isNotEmpty
                      ? Container(
                          height: 230,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: addCarController.addCarImageList.isNotEmpty
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(addCarController
                                          .addCarImageList.last))
                                  : null,
                              border: Border.all(color: Color(0XFFD8DEF1)),
                              borderRadius: BorderRadius.circular(10)),
                        )
                      : InkWell(
                          onTap: () {
                            imagePickerController.showImagePicker(
                                context: context,
                                fromGalleryList:
                                    addCarController.addCarImageList,
                                fromCameraList:
                                    addCarController.addCarImageList);
                          },
                          child: Container(
                            height: 230,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0XFFD8DEF1)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.add, color: Colors.blue, size: 24),
                                SizedBox(height: 5),
                                Text(
                                  "Add Car Image",
                                  style: TextStyle(
                                      color: Color(0XFFACACAC),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                  CustomSize(),
                  CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Car Name';
                      }
                      return null;
                    },
                    controller: addCarController.carName,
                    hintText: "Car Name",
                  ),
                  CustomSize(),
                  Container(
                    height: 49,
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Color(0XFFD8DEF1))),
                    width: double.infinity,
                    child: DropdownButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0XFFACACAC),
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      isExpanded: true,
                      hint: const Text(
                        "Choose Company",
                        style: TextStyle(
                            color: Color(0XFFACACAC),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                      underline: const SizedBox(),
                      iconEnabledColor: Colors.black38,
                      dropdownColor: Colors.white,
                      value: addCarController.selectedCompany.value,
                      items: addCarController.companies.map((selectedType) {
                        return DropdownMenuItem(
                          value: selectedType,
                          child: Text(
                            selectedType,
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        addCarController.setSelected(newValue!);
                      },
                    ),
                  ),
                  CustomSize(),
                  CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Car Model';
                      }
                      return null;
                    },
                    controller: addCarController.carModel,
                    keyboardType: TextInputType.number,
                    hintText: "Car Model",
                  ),
                  CustomSize(),
                  CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Car Registration No';
                      }
                      return null;
                    },
                    controller: addCarController.carRegNo,
                    keyboardType: TextInputType.number,
                    hintText: "Car Reg No:",
                  ),
                  CustomSize(),
                  CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Car Price';
                      }
                      return null;
                    },
                    controller: addCarController.carPrice,
                    keyboardType: TextInputType.number,
                    hintText: "Car Price",
                  ),
                  CustomSize(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WillPopScope(
                                  onWillPop: () async => false,
                                  child: AlertDialog(
                                    title: Text('Pick a color!'),
                                    contentPadding: EdgeInsets.zero,
                                    content: SingleChildScrollView(
                                      child: BlockPicker(
                                        pickerColor:
                                            addCarController.myColor.value,
                                        onColorChanged: (Color color) {
                                          addCarController.myColor.value =
                                              color;
                                        },
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('DONE'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text("Pick Color"),
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: addCarController.myColor.value,
                      )
                    ],
                  ),
                  CustomSize(),
                  addCarController.isLoading.value == false
                      ? ReuseableButton(
                          buttontext: "Add Car",
                          onpress: () {
                            if (addCarController.formKey.currentState!
                                .validate()) {
                              /// Add function call
                              addCarController.AddCar();
                            }
                          })
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  CustomSize()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
