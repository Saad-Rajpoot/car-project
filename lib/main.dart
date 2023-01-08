import 'package:car_project/Constants/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/home_screen.dart';
import 'Screens/welcome_screen.dart';

int? userInfo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  /// get value from shared preferences
  userInfo = prefs.getInt('User');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      ///condition check when user is open the app
      /// if user is already signup or not
      ///if signup then directly navigate to home screen
      ///otherwise will go to welcome screen
      initialRoute: userInfo == 0  ? '/home_screen' : '/welcome_screen',
      title: 'Car Project',
      getPages: [
        GetPage(
            name: '/home_screen',
            page: () => HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: '/welcome_screen',
            page: () => WelcomeScreen(),
            binding: HomeBinding()),
      ],
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Color(0XFFD8DEF1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.blue,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
