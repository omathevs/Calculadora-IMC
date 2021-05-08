import 'package:calculadora_imc/core/app_images.dart';
import 'package:calculadora_imc/pages/homepage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Image.asset(AppImages.balance),
          ),
        ),
      ),
    );
  }
}
