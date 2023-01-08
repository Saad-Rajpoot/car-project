import 'package:car_project/widgets/reusable_button.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 50),
            const Text(
              'Welcome!',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur elit lectus adipiscing lectus augue penatibus eros mass.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF808080),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 40),
            ///custom reuseable button for login
            ReuseableButton(
                buttontext: 'Login',
                onpress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                }),
            const SizedBox(height: 15),
            const Text(
              'OR',
              style: TextStyle(
                  color: Color(0XFF1FA0D0),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ///custom reuseable button for signup
            ReuseableButton(
                buttontext: 'SignUp',
                onpress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                }),
          ],
        ),
      ),
    );
  }
}