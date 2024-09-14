import 'package:flutter/material.dart';
import 'dart:math'; // Import for sqrt

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiCalculator(),
    );
  }
}

class MultiCalculator extends StatefulWidget {
  @override
  _MultiCalculatorState createState() => _MultiCalculatorState();
}

class _MultiCalculatorState extends State<MultiCalculator> {
  final _bmiWeightController = TextEditingController();
  final _bmiHeightController = TextEditingController();
  final _ageController = TextEditingController();
  final _tipAmountController = TextEditingController();
  final _tipPercentageController = TextEditingController();
  final _currencyAmountController = TextEditingController();
  final _quadraticAController = TextEditingController();
  final _quadraticBController = TextEditingController();
  final _quadraticCController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _fuelConsumedController = TextEditingController();
  final _distanceFuelController = TextEditingController();
  final _originalPriceController = TextEditingController();
  final _discountPercentageController = TextEditingController();
  final _distanceSDTController = TextEditingController();
  final _timeController = TextEditingController();
  final _speedController = TextEditingController();
  List<String> _todoList = [];
  List<bool> _completedList = [];
  String _selectedCalculation = 'Speed';

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
                controller: _bmiWeightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _bmiHeightController,
                decoration: InputDecoration(labelText: 'Height (m)'),
                keyboardType: TextInputType.number,
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
                double weight = double.parse(_bmiWeightController.text);
                double height = double.parse(_bmiHeightController.text);
                double bmi = weight / (height * height);
                _showResultDialog('BMI: ${bmi.toStringAsFixed(2)}');
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
          content: TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Enter your birth year'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                int birthYear = int.parse(_ageController.text);
                int currentYear = DateTime.now().year;
                int age = currentYear - birthYear;
                _showResultDialog('Your age is: $age');
              },
              child: Text('Calculate'),
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
                controller: _tipAmountController,
                decoration: InputDecoration(labelText: 'Bill Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _tipPercentageController,
                decoration: InputDecoration(labelText: 'Tip Percentage'),
                keyboardType: TextInputType.number,
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
                double billAmount = double.parse(_tipAmountController.text);
                double tipPercentage = double.parse(_tipPercentageController.text);
                double tip = billAmount * (tipPercentage / 100);
                _showResultDialog('Tip Amount: \$${tip.toStringAsFixed(2)}');
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
          content: TextField(
            controller: _currencyAmountController,
            decoration: InputDecoration(labelText: 'Enter Amount in USD'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double amountUSD = double.parse(_currencyAmountController.text);
                double conversionRate = 0.85; // Example conversion rate to EUR
                double amountEUR = amountUSD * conversionRate;
                _showResultDialog('Equivalent Amount in EUR: €${amountEUR.toStringAsFixed(2)}');
              },
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
                controller: _quadraticAController,
                decoration: InputDecoration(labelText: 'a'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _quadraticBController,
                decoration: InputDecoration(labelText: 'b'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _quadraticCController,
                decoration: InputDecoration(labelText: 'c'),
                keyboardType: TextInputType.number,
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
                double a = double.parse(_quadraticAController.text);
                double b = double.parse(_quadraticBController.text);
                double c = double.parse(_quadraticCController.text);
                double discriminant = (b * b) - (4 * a * c);
                if (discriminant >= 0) {
                  double root1 = (-b + sqrt(discriminant)) / (2 * a);
                  double root2 = (-b - sqrt(discriminant)) / (2 * a);
                  _showResultDialog('Roots: $root1 and $root2');
                } else {
                  _showResultDialog('No real roots exist.');
                }
              },
              child: Text('Solve'),
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
          content: TextField(
            controller: _temperatureController,
            decoration: InputDecoration(labelText: 'Temperature in Celsius'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double celsius = double.parse(_temperatureController.text);
                double fahrenheit = (celsius * 9 / 5) + 32;
                _showResultDialog('Temperature in Fahrenheit: ${fahrenheit.toStringAsFixed(2)} °F');
              },
              child: Text('Convert'),
            ),
          ],
        );
      },
    );
  }

  // Fuel Average Calculator Dialog
  void _showFuelEfficiencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fuel Average Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _distanceFuelController,
                decoration: InputDecoration(labelText: 'Distance Travelled (km)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _fuelConsumedController,
                decoration: InputDecoration(labelText: 'Fuel Consumed (liters)'),
                keyboardType: TextInputType.number,
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
                double distance = double.parse(_distanceFuelController.text);
                double fuel = double.parse(_fuelConsumedController.text);
                double efficiency = distance / fuel;
                _showResultDialog('Fuel Efficiency: ${efficiency.toStringAsFixed(2)} km/l');
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
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
                decoration: InputDecoration(labelText: 'Original Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _discountPercentageController,
                decoration: InputDecoration(labelText: 'Discount Percentage'),
                keyboardType: TextInputType.number,
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
                double originalPrice = double.parse(_originalPriceController.text);
                double discountPercentage = double.parse(_discountPercentageController.text);
                double discountAmount = originalPrice * (discountPercentage / 100);
                double finalPrice = originalPrice - discountAmount;
                _showResultDialog('Final Price: \$${finalPrice.toStringAsFixed(2)}');
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // Speed/Distance/Time Calculator Dialog
  void _showSpeedDistanceTimeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Speed/Distance/Time Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedCalculation,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCalculation = newValue!;
                  });
                },
                items: <String>['Speed', 'Distance', 'Time'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: _speedController,
                decoration: InputDecoration(labelText: 'Speed (km/h)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _distanceSDTController,
                decoration: InputDecoration(labelText: 'Distance (km)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time (h)'),
                keyboardType: TextInputType.number,
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
                double speed = double.parse(_speedController.text);
                double distance = double.parse(_distanceSDTController.text);
                double time = double.parse(_timeController.text);

                if (_selectedCalculation == 'Speed') {
                  speed = distance / time;
                  _showResultDialog('Calculated Speed: ${speed.toStringAsFixed(2)} km/h');
                } else if (_selectedCalculation == 'Distance') {
                  distance = speed * time;
                  _showResultDialog('Calculated Distance: ${distance.toStringAsFixed(2)} km');
                } else if (_selectedCalculation == 'Time') {
                  time = distance / speed;
                  _showResultDialog('Calculated Time: ${time.toStringAsFixed(2)} h');
                }
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // To-Do List Dialog
  void _showTodoListDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newTask = '';
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('To-Do List'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      newTask = value;
                    },
                    decoration: InputDecoration(labelText: 'New Task'),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _todoList.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(_todoList[index]),
                        value: _completedList[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _completedList[index] = value!;
                          });
                        },
                      );
                    },
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
                    setState(() {
                      _todoList.add(newTask);
                      _completedList.add(false);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Add Task'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to show results in dialog
  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(result),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Main calculator grid layout
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
          _buildCalculatorButton('BMI', 'bmi'),
          _buildCalculatorButton('Age', 'age'),
          _buildCalculatorButton('Tip', 'tip'),
          _buildCalculatorButton('Currency', 'currency'),
          _buildCalculatorButton('Quadratic', 'quadratic'),
          _buildCalculatorButton('Temperature', 'temperature'),
          _buildCalculatorButton('Fuel Efficiency', 'fuel'),
          _buildCalculatorButton('Discount', 'discount'),
          _buildCalculatorButton('Speed/Distance/Time', 'speed_distance_time'),
          _buildCalculatorButton('To-Do List', 'todo'),
        ],
      ),
    );
  }

  // Button builder
  Widget _buildCalculatorButton(String title, String type) {
    return ElevatedButton(
      onPressed: () => _showCalculatorDialog(type),
      child: Text(title),
    );
  }

  // Handle calculator dialog selection
  void _showCalculatorDialog(String type) {
    switch (type) {
      case 'bmi':
        _showBMIDialog();
        break;
      case 'age':
        _showAgeDialog();
        break;
      case 'tip':
        _showTipDialog();
        break;
      case 'currency':
        _showCurrencyConverterDialog();
        break;
      case 'quadratic':
        _showQuadraticDialog();
        break;
      case 'temperature':
        _showTemperatureConverterDialog();
        break;
      case 'fuel':
        _showFuelEfficiencyDialog();
        break;
      case 'discount':
        _showDiscountDialog();
        break;
      case 'speed_distance_time':
        _showSpeedDistanceTimeDialog();
        break;
      case 'todo':
        _showTodoListDialog();
        break;
      default:
        _showResultDialog('Unknown calculator type');
    }
  }
}
