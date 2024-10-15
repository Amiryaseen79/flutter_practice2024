import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Color) changeAppBarColor; // Function to change app bar color on main page
  final Color currentAppBarColor;

  SettingsScreen({required this.changeAppBarColor, required this.currentAppBarColor});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Color selectedColor = Colors.blue; // Default selected color
  Color settingsBackgroundColor = Colors.white; // Background color for settings page

  @override
  void initState() {
    super.initState();
    selectedColor = widget.currentAppBarColor;
  }

  // Function to update both the app bar color on main page and settings page background color
  void updateColors(Color color) {
    setState(() {
      selectedColor = color;
      settingsBackgroundColor = color.withOpacity(0.2); // Lighter background for settings
    });
    widget.changeAppBarColor(color); // Update the app bar color on main page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: selectedColor, // Apply selected color to app bar
        actions: [
          PopupMenuButton<Color>(
            onSelected: (Color color) {
              updateColors(color); // Change app bar and background color on select
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Color>>[
              const PopupMenuItem<Color>(
                value: Colors.red,
                child: Text('Red'),
              ),
              const PopupMenuItem<Color>(
                value: Colors.green,
                child: Text('Green'),
              ),
              const PopupMenuItem<Color>(
                value: Colors.blue,
                child: Text('Blue'),
              ),
            ],
            icon: Icon(Icons.color_lens), // Icon to trigger the color picker
          ),
        ],
      ),
      body: Container(
        color: settingsBackgroundColor, // Apply selected color to background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.red),
              title: Text('Red'),
              onTap: () {
                updateColors(Colors.red); // Change app bar and background color to red
              },
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.green),
              title: Text('Green'),
              onTap: () {
                updateColors(Colors.green); // Change app bar and background color to green
              },
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.blue),
              title: Text('Blue'),
              onTap: () {
                updateColors(Colors.blue); // Change app bar and background color to blue
              },
            ),
          ],
        ),
      ),
    );
  }
}
