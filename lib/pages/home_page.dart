import 'package:flutter/material.dart';

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
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}