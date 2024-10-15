import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_sharedprefrences/settingpage.dart';
import 'settings_page.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Color appBarColor = Colors.blue; // Default app bar color

  @override
  void initState() {
    super.initState();
    loadAppBarColor();
  }

  // Load saved app bar color from Shared Preferences
  Future<void> loadAppBarColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int? colorValue = prefs.getInt('appBarColor');
      if (colorValue != null) {
        appBarColor = Color(colorValue);
      }
    });
  }

  // Save app bar color to Shared Preferences
  Future<void> saveAppBarColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('appBarColor', color.value);
  }

  // Change app bar color
  void changeAppBarColor(Color color) {
    setState(() {
      appBarColor = color;
    });
    saveAppBarColor(color); // Save the color change
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List with Color Picker',
      debugShowCheckedModeBanner: false,
      home: TodoScreen(changeAppBarColor: changeAppBarColor, appBarColor: appBarColor),
    );
  }
}

class TodoScreen extends StatefulWidget {
  final Function(Color) changeAppBarColor;
  final Color appBarColor;

  TodoScreen({required this.changeAppBarColor, required this.appBarColor});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<String> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load saved tasks from Shared Preferences
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
      filteredTasks = tasks; // Initialize filtered list
    });
  }

  // Save the updated task list to Shared Preferences
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  // Add a new task
  void addTask() {
    setState(() {
      tasks.add(taskController.text);
      taskController.clear();
      filteredTasks = tasks; // Update filtered tasks
      saveTasks(); // Save the tasks to Shared Preferences
    });
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      filteredTasks = tasks; // Update filtered tasks
      saveTasks();
    });
  }

  // Search tasks
  void searchTasks(String query) {
    setState(() {
      filteredTasks = tasks
          .where((task) => task.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text('MAIN'), centerTitle: true,
        backgroundColor: widget.appBarColor, // Apply the selected app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    changeAppBarColor: widget.changeAppBarColor,
                    currentAppBarColor: widget.appBarColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Box
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                fillColor: Colors.grey[200], // Background color for the search box
                filled: true,
              ),
              onChanged: searchTasks,
            ),
            SizedBox(height: 16), // Add spacing between search and input boxes
            // Input Box for adding tasks
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Enter a task',
                border: OutlineInputBorder(),
                fillColor: Colors.grey[200], // Background color for the input box
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            // Floating Action Button for adding tasks
            FloatingActionButton(
              onPressed: addTask,
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 20),
            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(child: Text(filteredTasks[index])), // Centered text
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteTask(index),
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
