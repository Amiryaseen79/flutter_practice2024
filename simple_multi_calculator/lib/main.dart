import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Date formatting in Age Calculator

void main() {
  runApp(MultiCalculator());
}

class MultiCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MultiCalculatorScreen extends StatefulWidget {
  @override
  _MultiCalculatorScreenState createState() => _MultiCalculatorScreenState();
}

class _MultiCalculatorScreenState extends State<MultiCalculatorScreen> {
  String _selectedCalculator = '';

  // Controllers for BMI Calculator
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;
  String _bmiCategory = '';

  // Controllers for Age Calculator
  DateTime? _selectedDate;
  int _age = 0;

  // Controllers for Tip Calculator
  final TextEditingController _billAmountController = TextEditingController();
  final TextEditingController _tipPercentageController = TextEditingController();
  double _totalTip = 0.0;

  // Method to show only one calculator at a time
  void _showCalculator(String calculator) {
    setState(() {
      _selectedCalculator = calculator;
    });
  }

  // BMI Calculation
  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      setState(() {
        _bmi = weight / (height * height);
        _bmiCategory = _getBMICategory(_bmi);
      });
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal weight";
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }

  // Age Calculation
  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _age = DateTime.now().year - pickedDate.year;
      });
    }
  }

  // Tip Calculation
  void _calculateTip() {
    final double? billAmount = double.tryParse(_billAmountController.text);
    final double? tipPercentage = double.tryParse(_tipPercentageController.text);

    if (billAmount != null && tipPercentage != null && billAmount > 0 && tipPercentage > 0) {
      setState(() {
        _totalTip = (billAmount * (tipPercentage / 100));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Calculator'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade300,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Buttons to switch calculators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showCalculator('bmi'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                      minimumSize: Size(80, 80), // Ensures the button is circular
                      primary: Colors.blue, // Button color
                    ),
                    child: Text('BMI'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showCalculator('age'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                      minimumSize: Size(80, 80),
                      primary: Colors.green, // Button color
                    ),
                    child: Text('Age'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showCalculator('tip'),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(24),
                      minimumSize: Size(80, 80),
                      primary: Colors.orange, // Button color
                    ),
                    child: Text('Tip'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Display BMI Calculator
              if (_selectedCalculator == 'bmi') ...[
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter height in meters',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter weight in kilograms',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: Text('Calculate BMI'),
                ),
                SizedBox(height: 20),
                if (_bmi > 0) ...[
                  Text(
                    'Your BMI: ${_bmi.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Category: $_bmiCategory',
                    style: TextStyle(fontSize: 20),
                  ),
                ]
              ],

              // Display Age Calculator
              if (_selectedCalculator == 'age') ...[
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Your Birthdate'),
                ),
                SizedBox(height: 20),
                if (_selectedDate != null) ...[
                  Text(
                    "Selected Date: ${DateFormat('yMMMMd').format(_selectedDate!)}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Age: $_age years',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ],

              // Display Tip Calculator
              if (_selectedCalculator == 'tip') ...[
                TextField(
                  controller: _billAmountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter Bill Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _tipPercentageController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Enter Tip Percentage',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateTip,
                  child: Text('Calculate Tip'),
                ),
                SizedBox(height: 20),
                if (_totalTip > 0) ...[
                  Text(
                    'Total Tip: \$${_totalTip.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ]
              ],
            ],
          ),
        ),
      ),
    );
  }
}
