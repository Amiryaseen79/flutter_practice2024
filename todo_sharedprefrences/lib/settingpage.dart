import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;
  SettingsScreen({required this.toggleTheme, required this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                toggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
