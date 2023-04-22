import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:soil_app/utils/Colors.dart';

class AccDetails extends StatefulWidget {
  const AccDetails({super.key});

  @override
  State<AccDetails> createState() => _AccDetailsState();
}

class _AccDetailsState extends State<AccDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c3,
      appBar: AppBar(
        backgroundColor: AppColors.c4,
        foregroundColor: AppColors.c0,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/edit');
          }, icon: Icon(Icons.edit)),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Text('Hello')
          ],
        ),
      ),
    );
  }
}