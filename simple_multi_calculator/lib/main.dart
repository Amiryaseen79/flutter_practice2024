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
        scaffoldBackgroundColor: Colors.white,
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
  DateTime _selectedDate = DateTime.now();
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
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null && selectedDate != _selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
        int age = DateTime.now().year - selectedDate.year;
        if (DateTime.now().month < selectedDate.month ||
            (DateTime.now().month == selectedDate.month && DateTime.now().day < selectedDate.day)) {
          age--;
        }
        _showResultDialog('Your age is: $age');
      }
    });
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
                double average = distance / fuel;
                _showResultDialog('Fuel Average: ${average.toStringAsFixed(2)} km/l');
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
                double discount = (originalPrice * discountPercentage) / 100;
                double finalPrice = originalPrice - discount;
                _showResultDialog('Final Price after Discount: \$${finalPrice.toStringAsFixed(2)}');
              },
              child: Text('Calculate'),
            ),
          ],
        );
      },
    );
  }

  // Speed, Distance, Time Calculator Dialog
  void _showSDTDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Speed, Distance, Time Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              TextField(
                controller: _speedController,
                decoration: InputDecoration(labelText: 'Speed (km/h)'),
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
                double distance = double.tryParse(_distanceSDTController.text) ?? 0;
                double time = double.tryParse(_timeController.text) ?? 0;
                double speed = double.tryParse(_speedController.text) ?? 0;

                if (distance != 0 && time != 0) {
                  speed = distance / time;
                  _showResultDialog('Speed: ${speed.toStringAsFixed(2)} km/h');
                } else if (speed != 0 && time != 0) {
                  distance = speed * time;
                  _showResultDialog('Distance: ${distance.toStringAsFixed(2)} km');
                } else if (speed != 0 && distance != 0) {
                  time = distance / speed;
                  _showResultDialog('Time: ${time.toStringAsFixed(2)} hours');
                } else {
                  _showResultDialog('Please enter at least two values.');
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
  void _showTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController taskController = TextEditingController();
        return AlertDialog(
          title: Text('To-Do List'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Enter Task'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String task = taskController.text;
                if (task.isNotEmpty) {
                  setState(() {
                    _todoList.add(task);
                    _completedList.add(false);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Show Result Dialog
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              _buildCalculatorButton('BMI Calculator', _showBMIDialog),
              _buildCalculatorButton('Age Calculator', _showAgeDialog),
              _buildCalculatorButton('Tip Calculator', _showTipDialog),
              _buildCalculatorButton('Currency Converter', _showCurrencyConverterDialog),
              _buildCalculatorButton('Quadratic Equation Solver', _showQuadraticDialog),
              _buildCalculatorButton('Temperature Converter', _showTemperatureConverterDialog),
              _buildCalculatorButton('Fuel Average Calculator', _showFuelEfficiencyDialog),
              _buildCalculatorButton('Discount Calculator', _showDiscountDialog),
              _buildCalculatorButton('Speed, Distance, Time Calculator', _showSDTDialog),
              _buildCalculatorButton('To-Do List', _showTodoDialog),
              _buildTodoList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalculatorButton(String title, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          padding: EdgeInsets.all(16.0),
          shape: CircleBorder(),
          side: BorderSide(color: Colors.white, width: 2),
          textStyle: TextStyle(fontSize: 16),
          backgroundColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(title, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        _todoList.length,
            (index) => ListTile(
          title: Text(
            _todoList[index],
            style: TextStyle(
              decoration: _completedList[index] ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: _completedList[index],
            onChanged: (value) {
              setState(() {
                _completedList[index] = value ?? false;
              });
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _todoList.removeAt(index);
                _completedList.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
}
