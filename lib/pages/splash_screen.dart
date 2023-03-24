import 'package:flutter/material.dart';
import 'package:soil_app/pages/login_page.dart';
import 'package:soil_app/utils/Colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.c1,
              AppColors.c2,
              AppColors.c3,
              AppColors.c4,
              AppColors.c5,
            ],
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Image.asset(
                'lib/images/loginscreen/TextLogo.png',
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 200,
              ),
              Text(
                "The Soil App | Version 0.1",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
