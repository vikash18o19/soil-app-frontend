import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:soil_app/pages/image_pick.dart';
import 'package:soil_app/pages/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static List<Widget> _widgetOptions = <Widget>[
    Image.asset(
      'lib/images/loginscreen/TextLogo.png',
      height: 250,
      width: 250,
    ),
    ImgPicker(),
    Text(
      'History',
    ),
    Text(
      'Profile',
    ),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 173, 162),
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
                  Icons.phone_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'About Us',
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
      bottomNavigationBar: GNav(
        backgroundColor: (Colors.brown[700])!,
        rippleColor: (Colors.brown[400])!,
        hoverColor: (Colors.white70),
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            iconSize: 35,
            iconColor: Colors.white,
          ),
          GButton(
            icon: Icons.camera_outlined,
            iconSize: 35,
            iconColor: Colors.white,
          ),
          GButton(
            icon: Icons.history_outlined,
            iconSize: 35,
            iconColor: Colors.white,
          ),
          GButton(
            icon: Icons.account_circle_outlined,
            iconSize: 35,
            iconColor: Colors.white,
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Center(
        child: HomePage._widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
