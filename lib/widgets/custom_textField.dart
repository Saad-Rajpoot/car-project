import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, this.controller,this.obscureText,this.suffix, this.hintText, this.keyboardType,  this.validator, this.maxlines, this.inputFormatters});
  TextEditingController? controller;
  String? hintText;
  TextInputType? keyboardType;
  int? maxlines;
  bool? obscureText = false;
  Widget? suffix;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      maxLines: maxlines ?? 1,
      obscureText: obscureText == null ? false : obscureText!,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0XFFACACAC)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
