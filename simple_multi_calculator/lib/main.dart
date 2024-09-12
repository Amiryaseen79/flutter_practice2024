import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiCalculatorScreen(),
    );
  }
}

class MultiCalculatorScreen extends StatefulWidget {
  @override
  _MultiCalculatorScreenState createState() => _MultiCalculatorScreenState();
}

class _MultiCalculatorScreenState extends State<MultiCalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _tipAmountController = TextEditingController();
  final TextEditingController _totalBillController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _currencyRateController = TextEditingController();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelConsumedController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPercentageController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _distanceSDTController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String _selectedTemperatureFrom = 'Celsius';
  String _selectedTemperatureTo = 'Celsius';
  String _selectedCalculation = 'Speed';
  List<String> _todoList = [];
  List<bool> _completedList = [];

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
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
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
                double height = double.parse(_heightController.text) / 100; // Convert cm to meters
                double weight = double.parse(_weightController.text);
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(_selectedDate == null
                    ? 'Select Date of Birth'
                    : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
              ),
              if (_selectedDate != null)
                Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                  style: TextStyle(fontSize: 16),
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
                if (_selectedDate != null) {
                  int age = _calculateAge(_selectedDate!);
                  _showResultDialog('Age: $age');
                } else {
                  _showResultDialog('Please select a date of birth.');
                }
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

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
                controller: _totalBillController,
                decoration: InputDecoration(labelText: 'Total Bill Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _tipAmountController,
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
                double totalBill = double.parse(_totalBillController.text);
                double tipPercentage = double.parse(_tipAmountController.text);
                double tipAmount = totalBill * (tipPercentage / 100);
                _showResultDialog('Tip Amount: \$${tipAmount.toStringAsFixed(2)}');
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
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _currencyRateController,
                decoration: InputDecoration(labelText: 'Currency Rate'),
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
                double amount = double.parse(_amountController.text);
                double currencyRate = double.parse(_currencyRateController.text);
                double convertedAmount = amount * currencyRate;
                _showResultDialog('Converted Amount: \$${convertedAmount.toStringAsFixed(2)}');
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
                controller: _aController,
                decoration: InputDecoration(labelText: 'a'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _bController,
                decoration: InputDecoration(labelText: 'b'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _cController,
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
                double a = double.parse(_aController.text);
                double b = double.parse(_bController.text);
                double c = double.parse(_cController.text);
                double discriminant = b * b - 4 * a * c;
                if (discriminant > 0) {
                  double root1 = (-b + math.sqrt(discriminant)) / (2 * a);
                  double root2 = (-b - math.sqrt(discriminant)) / (2 * a);
                  _showResultDialog('Roots: $root1 and $root2');
                } else if (discriminant == 0) {
                  double root = -b / (2 * a);
                  _showResultDialog('Root: $root');
                } else {
                  _showResultDialog('No Real Roots');
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _temperatureController,
                decoration: InputDecoration(labelText: 'Temperature'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: _selectedTemperatureFrom,
                onChanged: (value) {
                  setState(() {
                    _selectedTemperatureFrom = value!;
                  });
                },
                items: ['Celsius', 'Fahrenheit'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: _selectedTemperatureTo,
                onChanged: (value) {
                  setState(() {
                    _selectedTemperatureTo = value!;
                  });
                },
                items: ['Celsius', 'Fahrenheit'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                double temperature = double.parse(_temperatureController.text);
                if (_selectedTemperatureFrom == 'Celsius' &&
                    _selectedTemperatureTo == 'Fahrenheit') {
                  temperature = temperature * 9 / 5 + 32;
                } else if (_selectedTemperatureFrom == 'Fahrenheit' &&
                    _selectedTemperatureTo == 'Celsius') {
                  temperature = (temperature - 32) * 5 / 9;
                }
                _showResultDialog('Converted Temperature: ${temperature.toStringAsFixed(2)} $_selectedTemperatureTo');
              },
              child: Text('Convert'),
            ),
          ],
        );
      },
    );
  }

  // Fuel Efficiency Dialog
  void _showFuelEfficiencyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Fuel Efficiency'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _distanceController,
                decoration: InputDecoration(labelText: 'Distance (km)'),
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
                double distance = double.parse(_distanceController.text);
                double fuelConsumed = double.parse(_fuelConsumedController.text);
                double efficiency = distance / fuelConsumed;
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

  // To-Do List Dialog
  void _showTodoListDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('To-Do List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _todoList.add(value);
                      _completedList.add(false);
                    });
                    Navigator.of(context).pop();
                  }
                },
                decoration: InputDecoration(labelText: 'New Task'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        value: _completedList[index],
                        onChanged: (value) {
                          setState(() {
                            _completedList[index] = value!;
                          });
                        },
                      ),
                      title: Text(_todoList[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _todoList.removeAt(index);
                            _completedList.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Speed, Distance, Time Calculator Dialog
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
                onChanged: (value) {
                  setState(() {
                    _selectedCalculation = value!;
                  });
                },
                items: ['Speed', 'Distance', 'Time'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (_selectedCalculation == 'Speed') ...[
                TextField(
                  controller: _distanceSDTController,
                  decoration: InputDecoration(labelText: 'Distance (km)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(labelText: 'Time (hours)'),
                  keyboardType: TextInputType.number,
                ),
              ] else if (_selectedCalculation == 'Distance') ...[
                TextField(
                  controller: _speedController,
                  decoration: InputDecoration(labelText: 'Speed (km/h)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _timeController,
                  decoration: InputDecoration(labelText: 'Time (hours)'),
                  keyboardType: TextInputType.number,
                ),
              ] else if (_selectedCalculation == 'Time') ...[
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
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                double distance = double.tryParse(_distanceSDTController.text) ?? 0;
                double speed = double.tryParse(_speedController.text) ?? 0;
                double time = double.tryParse(_timeController.text) ?? 0;

                double result;
                if (_selectedCalculation == 'Speed') {
                  result = distance / time;
                  _showResultDialog('Speed: ${result.toStringAsFixed(2)} km/h');
                } else if (_selectedCalculation == 'Distance') {
                  result = speed * time;
                  _showResultDialog('Distance: ${result.toStringAsFixed(2)} km');
                } else if (_selectedCalculation == 'Time') {
                  result = distance / speed;
                  _showResultDialog('Time: ${result.toStringAsFixed(2)} hours');
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
  void _showAgeResultDialog(String result) {
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

  // Show Calculator Dialog
  void _showCalculatorDialog(String calculatorType) {
    switch (calculatorType) {
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
      case 'todo':
        _showTodoListDialog();
        break;
      case 'sdt':
        _showSpeedDistanceTimeDialog();
        break;
      default:
        _showResultDialog('Unknown calculator type');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Calculator'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCalculatorButton('BMI', 'bmi'),
          _buildCalculatorButton('Age', 'age'),
          _buildCalculatorButton('Tip', 'tip'),
          _buildCalculatorButton('Currency', 'currency'),
          _buildCalculatorButton('Quadratic', 'quadratic'),
          _buildCalculatorButton('Temperature', 'temperature'),
          _buildCalculatorButton('Fuel', 'fuel'),
          _buildCalculatorButton('Discount', 'discount'),
          _buildCalculatorButton('To-Do List', 'todo'),
          _buildCalculatorButton('Speed/Distance/Time', 'sdt'),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String label, String calculatorType) {
    return Card(
      child: InkWell(
        onTap: () => _showCalculatorDialog(calculatorType),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
