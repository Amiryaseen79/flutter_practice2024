import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_sharedprefrences/settingpage.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  // Load saved theme from Shared Preferences
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme to Shared Preferences
  Future<void> saveTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  // Toggle between Light and Dark mode
  void toggleTheme(bool value) {
    setState(() {
      isDarkMode = value;
      saveTheme(isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List with Theme',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false, // Disable debug banner
      home: TodoScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
    );
  }
}

class TodoScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  TodoScreen({required this.toggleTheme, required this.isDarkMode});

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
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    toggleTheme: widget.toggleTheme,
                    isDarkMode: widget.isDarkMode,
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
