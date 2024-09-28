// ignore_for_file: prefer_const_constructors, prefer_final_fields, library_private_types_in_public_api, use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  bool isFahrenheitToCelsius = true; // to choose between F to C and C to F
  final TextEditingController _temperatureController = TextEditingController(); // Controller for input field
  String _result = ''; // this is where the result of conversion will be stored.
  List<String> _history = []; // this is the history of conversions will be stored. 

  // function to clear the input and reset state
  void _clear() {
    _temperatureController.clear(); 
    setState(() {
      _result = ''; 
      _history.clear(); 
    });
  }

  // Method to handle conversion logic
  void _convertTemperature() {
    if (_temperatureController.text.isEmpty) return; // Ensure input is provided

    double inputTemp = double.parse(_temperatureController.text); // Parse input to double
    double convertedTemp; // Variable that store the converted temperature
    String operation; // To track if conversion is F to C or C to F

    if (isFahrenheitToCelsius) {
      convertedTemp = _fahrenheitToCelsius(inputTemp); // Convert Fahrenheit to Celsius
      operation = 'F to C'; 
    } else {
      convertedTemp = _celsiusToFahrenheit(inputTemp); // Convert Celsius to Fahrenheit
      operation = 'C to F'; 
    }

    // Update the result and history
    setState(() {
      _result = convertedTemp.toStringAsFixed(2); // Format result to two decimal places
      _history.insert(0, '$operation : ${inputTemp.toStringAsFixed(1)} = $_result'); // Add to history
    });
  }

  // Fahrenheit to Celsius conversion
  double _fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  // Celsius to Fahrenheit conversion
  double _celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Description
                  Text(
                    'Select your preferred conversion option and enter a temperature.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),

                  // Radio Buttons for Conversion Options (in columns)
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            RadioListTile<bool>(
                              title: Text('Fahrenheit to Celsius',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              value: true,
                              groupValue: isFahrenheitToCelsius,
                              onChanged: (value) {
                                setState(() => isFahrenheitToCelsius = value!);
                              },
                            ),
                            RadioListTile<bool>(
                              title: Text('Celsius to Fahrenheit',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              value: false,
                              groupValue: isFahrenheitToCelsius,
                              onChanged: (value) {
                                setState(() => isFahrenheitToCelsius = value!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Temperature Input Field
                  TextField(
                    controller: _temperatureController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Enter temperature',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      ElevatedButton(
                        onPressed: _convertTemperature, 
                        child: Text('Convert', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 209, 219, 209),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: _clear,
                        child: Text('Reset', style: TextStyle(fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 215, 222, 215),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ] 
                  ),
                  SizedBox(height: 16),

                  // Result Display
                  Text(
                    'Result: $_result ${isFahrenheitToCelsius ? '°C' : '°F'}',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Conversion History
                  Text(
                    'Conversion History:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // Display history as a list of cards
                  SizedBox(
                    height: orientation == Orientation.portrait ? 200 : 100,
                    child: ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _history[index],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
