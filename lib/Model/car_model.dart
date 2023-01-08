import 'dart:ui';

class CarModel {
  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored CarModel.
  int? id;
  final String name;
  final String model;
  final String reg_no;
  final String company;
  final String color;
  final int price;
  final String image;


  CarModel({required this.name,required this.image, required this.model,required this.company,required this.reg_no, required this.color, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'model': model,
      'company': company,
      'reg_no': reg_no,
      'color': color,
      'price': price,
    };
  }

  static CarModel fromMap(Map<String, dynamic> map) {
    return CarModel(
      name: map['name'],
      image: map['image'],
      model: map['model'],
      company: map['company'],
      reg_no: map['reg_no'],
      color: map['color'],
      price: map['price'],
    );
  }
}
