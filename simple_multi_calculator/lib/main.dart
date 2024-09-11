import 'package:flutter/material.dart';
import 'dart:math'; // Import for square root in quadratic calculator

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

  // Controllers for existing calculators (BMI, Age, Tip, Currency)
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _billAmountController = TextEditingController();
  final TextEditingController _tipPercentageController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Controllers for Quadratic Equation Calculator
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();

  // Controllers for Temperature Converter
  final TextEditingController _temperatureController = TextEditingController();
  String _selectedTemperatureFrom = 'Celsius';
  String _selectedTemperatureTo = 'Fahrenheit';

  // Controllers for Fuel Efficiency Calculator
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelConsumedController = TextEditingController();

  // Controllers for Discount Calculator
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPercentageController = TextEditingController();

  // Methods for showing calculators
  void _showCalculatorDialog(String calculator) {
    setState(() {
      _selectedCalculator = calculator;
    });

    if (calculator == 'bmi') {
      _showBMIDialog();
    } else if (calculator == 'age') {
      _showAgeDialog();
    } else if (calculator == 'tip') {
      _showTipDialog();
    } else if (calculator == 'currency') {
      _showCurrencyConverterDialog();
    } else if (calculator == 'quadratic') {
      _showQuadraticDialog();
    } else if (calculator == 'temperature') {
      _showTemperatureConverterDialog();
    } else if (calculator == 'fuel') {
      _showFuelEfficiencyDialog();
    } else if (calculator == 'discount') {
      _showDiscountDialog();
    }
  }

  // BMI Calculator Dialog
  void _showBMIDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('BMI Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Height (m)'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Weight (kg)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final height = double.tryParse(_heightController.text);
                final weight = double.tryParse(_weightController.text);

                if (height != null && weight != null && height > 0) {
                  final bmi = weight / (height * height);
                  Navigator.of(context).pop(); // Close the dialog first
                  _showResultDialog('BMI: ${bmi.toStringAsFixed(2)}');
                } else {
                  Navigator.of(context).pop(); // Close the dialog first
                  _showResultDialog('Invalid input');
                }
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // Age Calculator Dialog
  void _showAgeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Age Calculator'),
          content: Text('Age calculator will be implemented here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Tip Calculator Dialog
  void _showTipDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tip Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _billAmountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Bill Amount'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _tipPercentageController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Tip Percentage'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final billAmount = double.tryParse(_billAmountController.text);
                final tipPercentage = double.tryParse(_tipPercentageController.text);

                if (billAmount != null && tipPercentage != null) {
                  final tip = billAmount * (tipPercentage / 100);
                  final totalAmount = billAmount + tip;
                  Navigator.of(context).pop(); // Close the dialog first
                  _showResultDialog('Tip: ${tip.toStringAsFixed(2)}, Total: ${totalAmount.toStringAsFixed(2)}');
                } else {
                  Navigator.of(context).pop(); // Close the dialog first
                  _showResultDialog('Invalid input');
                }
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // Currency Converter Dialog
  void _showCurrencyConverterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Currency Converter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Amount'),
              ),
              SizedBox(height: 16),
              Text('Conversion logic can be implemented here.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Currency conversion logic will go here
                Navigator.of(context).pop();
              },
              child: Text('Convert'),
            ),
          ],
        );
      },
    );
  }

  // Quadratic Equation Solver
  void _solveQuadratic() {
    final double? a = double.tryParse(_aController.text);
    final double? b = double.tryParse(_bController.text);
    final double? c = double.tryParse(_cController.text);

    if (a != null && b != null && c != null && a != 0) {
      final double discriminant = (b * b) - (4 * a * c);
      if (discriminant > 0) {
        double x1 = (-b + sqrt(discriminant)) / (2 * a);
        double x2 = (-b - sqrt(discriminant)) / (2 * a);
        Navigator.of(context).pop(); // Close the dialog first
        _showResultDialog('Roots are: x1 = ${x1.toStringAsFixed(2)}, x2 = ${x2.toStringAsFixed(2)}');
      } else if (discriminant == 0) {
        double x = -b / (2 * a);
        Navigator.of(context).pop(); // Close the dialog first
        _showResultDialog('Root is: x = ${x.toStringAsFixed(2)}');
      } else {
        Navigator.of(context).pop(); // Close the dialog first
        _showResultDialog('No real roots.');
      }
    }
  }

  // Temperature Converter
  void _convertTemperature() {
    final double? temperature = double.tryParse(_temperatureController.text);

    if (temperature != null) {
      double convertedTemp = 0.0;

      if (_selectedTemperatureFrom == 'Celsius' && _selectedTemperatureTo == 'Fahrenheit') {
        convertedTemp = (temperature * 9 / 5) + 32;
      } else if (_selectedTemperatureFrom == 'Fahrenheit' && _selectedTemperatureTo == 'Celsius') {
        convertedTemp = (temperature - 32) * 5 / 9;
      } else if (_selectedTemperatureFrom == 'Celsius' && _selectedTemperatureTo == 'Kelvin') {
        convertedTemp = temperature + 273.15;
      } else if (_selectedTemperatureFrom == 'Kelvin' && _selectedTemperatureTo == 'Celsius') {
        convertedTemp = temperature - 273.15;
      } else if (_selectedTemperatureFrom == 'Fahrenheit' && _selectedTemperatureTo == 'Kelvin') {
        convertedTemp = (temperature - 32) * 5 / 9 + 273.15;
      } else if (_selectedTemperatureFrom == 'Kelvin' && _selectedTemperatureTo == 'Fahrenheit') {
        convertedTemp = (temperature - 273.15) * 9 / 5 + 32;
      }
      Navigator.of(context).pop(); // Close the dialog first
      _showResultDialog('Converted Temperature: ${convertedTemp.toStringAsFixed(2)} $_selectedTemperatureTo');
    }
  }

  // Fuel Efficiency Calculator
  void _calculateFuelEfficiency() {
    final double? distance = double.tryParse(_distanceController.text);
    final double? fuelConsumed = double.tryParse(_fuelConsumedController.text);

    if (distance != null && fuelConsumed != null && fuelConsumed > 0) {
      final fuelEfficiency = distance / fuelConsumed;
      Navigator.of(context).pop(); // Close the dialog first
      _showResultDialog('Fuel Efficiency: ${fuelEfficiency.toStringAsFixed(2)} km/l');
    } else {
      Navigator.of(context).pop(); // Close the dialog first
      _showResultDialog('Invalid input');
    }
  }

  // Discount Calculator Dialog
  void _showDiscountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Discount Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _originalPriceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Original Price'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _discountPercentageController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Discount Percentage'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final originalPrice = double.tryParse(_originalPriceController.text);
                final discountPercentage = double.tryParse(_discountPercentageController.text);

                if (originalPrice != null && discountPercentage != null) {
                  final discountAmount = originalPrice * (discountPercentage / 100);
                  final discountedPrice = originalPrice - discountAmount;
                  Navigator.of(context).pop(); // Close the dialog first
                  _showResultDialog('Discount Amount: ${discountAmount.toStringAsFixed(2)}, Discounted Price: ${discountedPrice.toStringAsFixed(2)}');
                } else {
                  Navigator.of(context).pop(); // Close the dialog first
                  _showResultDialog('Invalid input');
                }
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // Common Result Dialog
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Fuel Efficiency Calculator Dialog
  void _showFuelEfficiencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fuel Efficiency Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _distanceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Distance (km)'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _fuelConsumedController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Fuel Consumed (l)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _calculateFuelEfficiency,
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // Temperature Converter Dialog
  void _showTemperatureConverterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Temperature Converter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _temperatureController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter Temperature'),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedTemperatureFrom,
                items: ['Celsius', 'Fahrenheit', 'Kelvin']
                    .map((unit) => DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTemperatureFrom = value!;
                  });
                },
                hint: Text('From'),
              ),
              DropdownButton<String>(
                value: _selectedTemperatureTo,
                items: ['Celsius', 'Fahrenheit', 'Kelvin']
                    .map((unit) => DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTemperatureTo = value!;
                  });
                },
                hint: Text('To'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
          ],
        );
      },
    );
  }

  // Quadratic Equation Solver Dialog
  void _showQuadraticDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quadratic Equation Solver'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _aController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter a'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _bController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter b'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _cController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Enter c'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _solveQuadratic();
              },
              child: Text('Solve'),
            ),
          ],
        );
      },
    );
  }

  // Main layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Calculator'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          _buildCalculatorButton('BMI Calculator', 'bmi'),
          _buildCalculatorButton('Age Calculator', 'age'),
          _buildCalculatorButton('Tip Calculator', 'tip'),
          _buildCalculatorButton('Currency Converter', 'currency'),
          _buildCalculatorButton('Quadratic Solver', 'quadratic'),
          _buildCalculatorButton('Temperature Converter', 'temperature'),
          _buildCalculatorButton('Fuel Efficiency', 'fuel'),
          _buildCalculatorButton('Discount Calculator', 'discount'),
        ],
      ),
    );
  }

  // Helper method to build calculator buttons with gradient background
  Widget _buildCalculatorButton(String label, String calculatorType) {
    return GestureDetector(
      onTap: () => _showCalculatorDialog(calculatorType),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(8),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
