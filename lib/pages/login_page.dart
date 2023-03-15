// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:soil_app/components/button.dart';
import 'package:soil_app/components/textfield.dart';
import 'package:soil_app/pages/home_page.dart';
import 'package:soil_app/utils/Colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> sendRequest(
      BuildContext context, String email, String password) async {
    final url = Uri.parse(
        'https://86b3-2401-4900-3b27-c3c-4ddf-41a5-4feb-b1a0.in.ngrok.io/user/signin'); // replace with your API URL

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // navigate to HomePage and prevent user from going back
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      // show an error message if request failed
      final error = json.decode(response.body)['message'];
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c1,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // logo
                Image.asset(
                  'lib/images/loginscreen/TextLogo.png',
                  height: 250,
                  width: 250,
                ),

                // const SizedBox(height: 50,),
                // welcome back
                // Text(
                //   'Please Login to continue!',
                //   style: TextStyle(
                //       color: AppColors.c5,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20.0),
                // ),

                const SizedBox(
                  height: 40,
                ),
                // username
                MyTextField(
                  controller: usernameController,
                  hintText: 'User Name',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                // password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                // forgot password
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.c4,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // sign in
                MyButton(
                  onTap: () => {
                    // sendRequest(context, usernameController.text,
                    //     passwordController.text)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ),
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a Member?',
                      style: TextStyle(
                          color: AppColors.c4,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Sign Up here!',
                      style: TextStyle(
                          color: AppColors.c5,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
