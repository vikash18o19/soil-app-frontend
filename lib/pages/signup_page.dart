import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:soil_app/components/appbar2.dart';
import 'package:soil_app/components/map.dart';
import 'package:soil_app/components/textfield.dart';
import 'package:soil_app/pages/image_pick.dart';
import 'package:soil_app/pages/login_page.dart';
import 'package:soil_app/utils/Colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phonenoController = TextEditingController();
  final mailaddController = TextEditingController();
  final passController = TextEditingController();
  final repassController = TextEditingController();

  bool isTapped = false;

  void _onTapDown() {
    setState(() {
      isTapped = true;
    }
    );
  }

  void _onTapUp() {
    setState(() {
      isTapped = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      isTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar2(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: AppColors.c5,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ralaway",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: MyTextField(
                    controller: firstnameController, 
                    hintText: 'First Name', 
                    obscureText: false
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: MyTextField(
                    controller: lastnameController, 
                    hintText: 'Last Name', 
                    obscureText: false
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: MyTextField(
                    controller: phonenoController, 
                    hintText: 'Phone No.', 
                    obscureText: false
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: MyTextField(
                    controller: mailaddController, 
                    hintText: 'e-mail address', 
                    obscureText: false
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: MyTextField(
                    controller: passController, 
                    hintText: 'Password', 
                    obscureText: true
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: MyTextField(
                    controller: repassController, 
                    hintText: 'Re-enter Password', 
                    obscureText: true
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTapDown: (_) => _onTapDown(),
                  onTapUp: (_) => _onTapUp(),
                  onTapCancel: () => _onTapCancel(),
                  child: ElevatedButton(
                    onPressed: () => {
                      
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTapped? AppColors.c0.withOpacity(0.3) : Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 133, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(color: AppColors.c0, width: 1.0,) ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.c0,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                  ),
                ),
              ],
            ),
          )
          ),
      ),
    );
  }
}

