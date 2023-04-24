import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soil_app/pages/about_us.dart';
import 'package:soil_app/pages/acc_details.dart';
import 'package:soil_app/pages/history.dart';
import 'package:soil_app/pages/search.dart';
import 'package:soil_app/pages/settings.dart';
import 'package:soil_app/pages/signup_page.dart';
import 'package:soil_app/utils/Colors.dart';

import 'login_page.dart';

class myAcc extends StatefulWidget {
  const myAcc({super.key});

  @override
  State<myAcc> createState() => _myAccState();
}

class _myAccState extends State<myAcc> {

  late File _image;
  bool _imageSelected = false;

  Future<void> _saveImage() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File('$path/profile.jpg');
  await file.writeAsBytes(_image.readAsBytesSync());
  }

  void _selectImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
      _imageSelected = true;
    });
  }
  }
  void _loadImage() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File('$path/profile.jpg');
  if (file.existsSync()) {
    setState(() {
      _image = file;
      _imageSelected = true;
    });
  }
  }




  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: AppColors.c4,
        height: sh,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: sw,
                  height: sw*0.5,
                  child: GestureDetector(
                    onTap: () {
                      _selectImage();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: AppColors.c3,
                      backgroundImage: 
                        // _imageSelected
                        //   ? FileImage(_image)
                        //   : 
                          const AssetImage('lib/images/homepage/default-pro-pic.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: sh*0.1,
                  width: sw,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.c5,
                    ),
                    onPressed: () {
                      _selectImage();
                    },
                    child: Text('Change Photo',
                              style: TextStyle(
                                color: AppColors.c0,
                                fontSize: 25,
                              ),),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>AccDetails()),);
                  },
                  child: Text(
                    'Account Details',
                    style: TextStyle(fontSize: 30, color: AppColors.c0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>History()),);
                  },
                  child: Text(
                    'My History',
                    style: TextStyle(fontSize: 30, color: AppColors.c0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> Settings() ));
                  },
                  child: Text(
                    'Settings',
                    style: TextStyle(fontSize: 30, color: AppColors.c0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>AboutUs()),);
                  },
                  child: Text(
                    'About Us',
                    style: TextStyle(fontSize: 30, color: AppColors.c0),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 30, color: AppColors.c0),
                  ),
                ),

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}