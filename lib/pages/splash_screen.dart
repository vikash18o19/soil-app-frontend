import 'package:flutter/material.dart';
import 'package:soil_app/pages/login_page.dart';

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
      backgroundColor: Color.fromARGB(255, 201, 173, 162),
      body: Center(
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
    );
  }
}
