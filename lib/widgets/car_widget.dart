import 'dart:io';
import 'package:car_project/Model/car_model.dart';
import 'package:flutter/material.dart';

class CarWidget extends StatelessWidget {
  CarWidget(this.car, this.carController);
  final CarModel car;
  var carController;

  @override
  Widget build(BuildContext context) {
    ///Change Material Color to Simple Color
    ///Means Color(0XFF000000) to Colors.white
    String valueString = car.color
        .split('(0x')[1]
        .split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color carColor = Color(value);
    return GestureDetector(
      ///Edit Screen Call
      onTap: () => carController.onEdit(car),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(car.name, style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
              subtitle: Text(
                car.company,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(70)),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => carController.showAlertDialog(context, car),
                      icon: const Icon(
                        Icons.delete,
                        size: 14,
                        color: Color(0XFFffffff),
                      )),
                ),
              ),
            ),
            Image.file(File(car.image),fit: BoxFit.cover, height: 120),
            Divider(color: Colors.black.withOpacity(0.6)),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Model: ',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: car.model.toString(),
                            style: const TextStyle(color: Colors.blue, fontSize: 14),

                          )
                        ]
                    ),
                  ),
                  SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                        text: 'Reg No: ',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: car.reg_no.toString(),
                            style: const TextStyle( color: Colors.blue, fontSize: 14),

                          )
                        ]
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Text("Color: ", style: const TextStyle(
                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: carColor,
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Text(
                    '\$${car.price}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}