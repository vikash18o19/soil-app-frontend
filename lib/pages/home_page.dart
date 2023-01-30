import 'package:flutter/material.dart';
import 'package:soil_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.brown[800],
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'My Account',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(
                  Icons.history_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'My History',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_applications_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
