import 'dart:io';

import 'package:car_project/Constants/constants.dart';
import 'package:car_project/Controllers/edit_car_controller.dart';
import 'package:car_project/Controllers/image_picker_controller.dart';
import 'package:car_project/widgets/custom_textField.dart';
import 'package:car_project/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class EditCarScreen extends StatelessWidget {
  /// Dependency injection
  final editCarController = Get.find<EditCarController>();
  final imagePickerController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    return  Obx(()=> Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text(
              'Edit Car',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Form(
              key: editCarController.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Reusable Widgets Calls
                    CustomSize(),
                    Container(
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0XFFC4C4C4)),
                          image: editCarController.editCarImageList.isNotEmpty ? DecorationImage(
                              fit: BoxFit.cover,
                              image:  FileImage(
                                  editCarController.editCarImageList.last) ): null,
                          borderRadius: BorderRadius.circular(10)),
                      child: editCarController.carImage.value == '' ? Container() :  Stack(
                        children: [
                          editCarController.editCarImageList.isEmpty? Center(child: Image.file(File(editCarController.carImage.value),fit: BoxFit.cover)) : Container(),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(70)
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  imagePickerController.showImagePicker(context: context, fromGalleryList: editCarController.editCarImageList, fromCameraList: editCarController.editCarImageList);
                                },
                                icon: const Icon(Icons.edit, size: 14,
                                  color: Color(0XFFffffff),),
                              ),
                            ),
                          ),
                        ],
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
                      controller: editCarController.editCarName,
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
                          border: Border.all(
                              width: 1, color: Color(0XFFD8DEF1))),
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
                        value: editCarController.selectedCompany.value,
                        items: editCarController.companies.map((selectedType) {
                          return DropdownMenuItem(
                            value: selectedType,
                            child: Text(
                              selectedType,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          editCarController.setSelected(newValue!);
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
                      controller: editCarController.editCarModel,
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
                      controller: editCarController.editCarRegNo,
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
                      controller: editCarController.editCarPrice,
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
                                          pickerColor: editCarController.myColor.value,
                                          onColorChanged: (Color color) {
                                            String newColor = color.toString();
                                            String valueString = newColor.split('(0x')[1]
                                                .split(')')[0].toString();
                                            int value = int.parse(valueString, radix: 16);
                                            Color carColor = Color(value);
                                            editCarController.myColor.value = carColor;
                                            print(color);
                                            print(editCarController.myColor.value);
                                            print(carColor);
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
                          backgroundColor: editCarController.myColor.value,
                        )
                      ],
                    ),
                    CustomSize(),
                    editCarController.isLoading.value == false
                        ? ReuseableButton(
                        buttontext: "Save",
                        onpress: () {
                          if (editCarController.formKey.currentState!
                              .validate()) {
                            editCarController.EditCar(editCarController.carController.carModel.value.id);
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