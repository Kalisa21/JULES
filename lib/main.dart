import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.green, // Primary color is green
        fontFamily: 'Montserrat', // Set Montserrat as the default font
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _conversionType = 'F to C'; // Default selection
  String _convertedValue = '';
  List<String> _history = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_tempController.text) ?? 0.0;
    double resultTemp;

    if (_conversionType == 'F to C') {
      resultTemp = (inputTemp - 32) * 5 / 9;
    } else {
      resultTemp = inputTemp * 9 / 5 + 32;
    }

    setState(() {
      _convertedValue = resultTemp.toStringAsFixed(2);
      _history.insert(0,
          "$_conversionType: $inputTemp => $_convertedValue"); // Add to history
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      backgroundColor: Colors.blue[900], // Set background color to dark blue
      body: SingleChildScrollView(  // Wrap in SingleChildScrollView for smaller screens
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Conversion selection (Radio buttons)
              Text(
                'Conversion:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Fahrenheit to Celsius',
                        style: TextStyle(color: Colors.white), // Set text to white
                      ),
                      leading: Radio<String>(
                        value: 'F to C',
                        groupValue: _conversionType,
                        onChanged: (String? value) {
                          setState(() {
                            _conversionType = value!;
                          });
                        },
                        activeColor: Colors.white, // Set active radio button color to white
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Celsius to Fahrenheit',
                        style: TextStyle(color: Colors.white), // Set text to white
                      ),
                      leading: Radio<String>(
                        value: 'C to F',
                        groupValue: _conversionType,
                        onChanged: (String? value) {
                          setState(() {
                            _conversionType = value!;
                          });
                        },
                        activeColor: Colors.white, // Set active radio button color to white
                      ),
                    ),
                  ),
                ],
              ),
              // User temperature entry
              TextField(
                controller: _tempController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white), // Set input text to white
                decoration: InputDecoration(
                  labelText: 'Enter temperature',
                  labelStyle: TextStyle(color: Colors.white), // Set label to white
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Set focused border color to white
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Convert button
              Center(
                child: ElevatedButton(
                  onPressed: _convertTemperature,
                  child: Text(
                    'CONVERT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Set button text to white
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 17, 17, 17), // Set button background to dark
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Converted value display
              Text(
                'Converted Value: $_convertedValue',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16),
              // History of conversions
              SizedBox(
                height: 150, // Add fixed height or use Flexible/Expanded
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _history[index],
                        style: TextStyle(
                            color: Colors.white), // Set history text to white
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
