import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:soil_app/components/textfield.dart';
import 'package:soil_app/utils/Colors.dart';
import 'package:soil_app/components/appbar2.dart';

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({super.key});

  @override
  State<ForgotpasswordPage> createState() => _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {

  final mailidController = TextEditingController();

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
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBar2(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Text(
                'Please enter your email address to receive the mail for changing password:',
                
                style: TextStyle(
                  color: AppColors.c0,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono' 
                ),
            
              ),
            ),
            SizedBox(
              height: 1
            ),
            SizedBox(
              height:50,
              width: 400,
              child: MyTextField(
                controller: mailidController, 
                hintText: 'e-mail id', 
                obscureText: false
              )
            ),
            SizedBox(
              height: 25
            ),
            GestureDetector(
              onTapDown: (_) => _onTapDown(),
              onTapUp: (_) => _onTapUp(),
              onTapCancel: () => _onTapCancel(),
              child: ElevatedButton(
                onPressed:() => {}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: isTapped? AppColors.c0.withOpacity(0.3) : Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: BorderSide(color: AppColors.c0, width: 1.0,) ),
                ),
                child: Text(
                  'Send mail',
                  style: TextStyle(
                    color: AppColors.c0,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            )
          ],
        ),
      ),
    );
  }
}