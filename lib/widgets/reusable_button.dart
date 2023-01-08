import 'package:flutter/material.dart';

class ReuseableButton extends StatelessWidget {
  String buttontext;
  Function()? onpress;
  ReuseableButton({
    required this.buttontext,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 46,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            buttontext,
            style: TextStyle(color: Color(0XFFFFFFFF), fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}