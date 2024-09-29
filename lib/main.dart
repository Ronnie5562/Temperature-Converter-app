import 'package:flutter/material.dart';

void main() => runApp(const RonaldTempConverterApp());

class RonaldTempConverterApp extends StatelessWidget {
  const RonaldTempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const DarkThemeConverterScreen(),
    );
  }
}

class DarkThemeConverterScreen extends StatefulWidget {
  const DarkThemeConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DarkThemeConverterScreenState createState() =>
      _DarkThemeConverterScreenState();
}

class _DarkThemeConverterScreenState extends State<DarkThemeConverterScreen> {
  String _selectedConversion = 'Fahrenheit to Celsius';
  final TextEditingController _controller = TextEditingController();
  String _convertedValue = '';
  final List<String> _conversionHistory = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_controller.text) ?? 0.0;
    double convertedTemp;
    String historyEntry;

    if (_selectedConversion == 'Fahrenheit to Celsius') {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      historyEntry =
          'F to C: $inputTemp => ${convertedTemp.toStringAsFixed(2)}';
    } else {
      convertedTemp = (inputTemp * 9 / 5) + 32;
      historyEntry =
          'C to F: $inputTemp => ${convertedTemp.toStringAsFixed(2)}';
    }

    setState(() {
      _convertedValue = convertedTemp.toStringAsFixed(2);
      _conversionHistory.insert(0, historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ronald Temp Converter'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.thermostat_outlined,
                    color: Colors.blue, size: 30),
                Radio<String>(
                  value: 'Fahrenheit to Celsius',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                const Text('F to C', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                const Icon(Icons.thermostat, color: Colors.red, size: 30),
                Radio<String>(
                  value: 'Celsius to Fahrenheit',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                const Text('C to F', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[700],
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('CONVERT', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Text(
              'Converted Value: $_convertedValue',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
            const Divider(color: Colors.white),
            Expanded(
              child: ListView.builder(
                itemCount: _conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.history, color: Colors.yellowAccent),
                    title: Text(
                      _conversionHistory[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
