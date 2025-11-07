import 'package:flutter/material.dart';

class Bmipage extends StatefulWidget {
  const Bmipage({Key? key}) : super(key: key);

  @override
  State<Bmipage> createState() => _BmipageState();
}

class _BmipageState extends State<Bmipage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _bmi;
  String _message = '';

  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text.trim());
    final double? height = double.tryParse(_heightController.text.trim());

    if (weight == null || height == null || height <= 0) {
      setState(() {
        _message = 'Please enter valid weight and height values.';
        _bmi = null;
      });
      return;
    }

    final double heightMeters = height / 100;
    final double bmi = weight / (heightMeters * heightMeters);

    setState(() {
      _bmi = bmi;
      if (bmi < 18.5) {
        _message = 'Underweight';
      } else if (bmi < 24.9) {
        _message = 'Normal weight';
      } else if (bmi < 29.9) {
        _message = 'Overweight';
      } else {
        _message = 'Obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            if (_bmi != null) ...[
              Text(
                'Your BMI is: ${_bmi!.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _message,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ] else ...[
              Text(
                _message,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
