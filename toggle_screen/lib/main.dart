import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GradientSwitchScreen(),
    );
  }
}
class GradientSwitchScreen extends StatefulWidget {
  @override
  _GradientSwitchScreenState createState() => _GradientSwitchScreenState();
}

class _GradientSwitchScreenState extends State<GradientSwitchScreen> {
  bool _isGradient = false;  // This boolean will track the state of the switch.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradient Switch'),
      ),
      body: Container(
        // If _isGradient is true, show the gradient, otherwise show white.
        decoration: BoxDecoration(
          gradient: _isGradient
              ? LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: _isGradient ? null : Colors.white,
        ),
        child: Center(
          child: Switch(
            value: _isGradient,
            onChanged: (value) {
              setState(() {
                _isGradient = value;  // Toggle between true and false.
              });
            },
          ),
        ),
      ),
    );
  }
}
