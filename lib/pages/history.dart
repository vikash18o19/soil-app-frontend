import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soil_app/utils/Colors.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<dynamic> _historyData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  Future<void> _fetchHistoryData() async {
    setState(() {
      _isLoading = true;
    });

    // Check if cached data is available
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('historyJson');
    if (historyJson != null) {
      setState(() {
        _historyData = jsonDecode(historyJson);
        _isLoading = false;
      });
      return;
    }

    // Fetch data from API
    final userId = prefs.getString('userId');
    final token = prefs.getString('token');
    final url = Uri.parse(
        'https://soil-app-backend.azurewebsites.net/prediction/history');
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: {'userId': userId},
    );
    final responseBody = jsonDecode(response.body);

    // Cache data in shared preferences
    prefs.setString('historyJson', jsonEncode(responseBody['data']));

    setState(() {
      _historyData = responseBody['data'];
      _isLoading = false;
    });
  }

  Future<void> _refreshHistoryData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('historyJson'); // Remove cached data

    _fetchHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c4,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.c5,
            ))
          : RefreshIndicator(
              onRefresh: _refreshHistoryData,
              child: ListView.builder(
                itemCount: _historyData.length,
                itemBuilder: (context, index) {
                  final soilType = _historyData[index]['soilType'];
                  final coordinates =
                      _historyData[index]['location']['coordinates'];
                  return Card(
                    color: AppColors.c3,
                    child: ListTile(
                      title: Text('Soil Type: $soilType'),
                      subtitle: Text(
                          'Coordinates: ${coordinates[0]}, ${coordinates[1]}'),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
