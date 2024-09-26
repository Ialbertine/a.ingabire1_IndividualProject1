// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'temperature.dart';  

class TemperatureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 8, 174, 14),
          title: Center(
            child: Text('Temperature Converter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        body: Center(child: TemperatureScreen()),
      ),
    );
  }
}

void main() {
  runApp(TemperatureApp());
}
