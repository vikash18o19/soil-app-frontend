// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:soil_app/components/button.dart';
import 'package:soil_app/components/textfield.dart';
import 'package:soil_app/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 173, 162),
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
                Text(
                  'Please Login to continue!',
                  style: TextStyle(color: Colors.brown, fontSize: 20),
                ),

                const SizedBox(
                  height: 25,
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
                  height: 10,
                ),
                // forgot password
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                // sign in
                MyButton(
                  onTap: ()=>{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
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
                      style: TextStyle(color: Colors.brown),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'Sign Up here!',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
