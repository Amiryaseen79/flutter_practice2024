//main dart
import 'package:flutter/material.dart';
import 'db_helper.dart'; // Ensure this is created correctly
import 'model/item.dart'; // Ensure the Item model is defined

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      debugShowCheckedModeBanner: false,  // Removes the debug banner
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Item>> items;
  TextEditingController controller = TextEditingController();
  String name = "";
  int? curItemId; // Changed from curUserId to curItemId for clarity
  final formKey = GlobalKey<FormState>();
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper(); // Initialize the DatabaseHelper class
    refreshList();
  }

  refreshList() {
    setState(() {
      items = dbHelper.getItems(); // Fetch all items
    });
  }

  clearName() {
    controller.text = '';
    curItemId = null;
  }

  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (curItemId == null) {
        // If no current item is selected, insert a new one
        dbHelper.insertItem(Item(name: name));
      } else {
        // Update the existing item
        dbHelper.updateItem(Item(id: curItemId, name: name));
      }
      clearName();
      refreshList(); // Refresh the list after any action
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val!.isEmpty ? 'Enter Name' : null,
              onSaved: (val) => name = val!,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Gray color for the button
              ),
              onPressed: validate,
              child: Text(curItemId == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  dataTable(List<Item> items) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Delete')),
      ],
      rows: items
          .map(
            (item) => DataRow(cells: [
          DataCell(
            Text(item.name),
            onTap: () {
              setState(() {
                curItemId = item.id;
                controller.text = item.name;
              });
            },
          ),
          DataCell(IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              dbHelper.deleteItem(item.id!);
              refreshList(); // Refresh after deleting
            },
          )),
        ]),
      )
          .toList(),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: items,
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: dataTable(snapshot.data!),
            );
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Text('No Data Found');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite CRUD'),
      ),
      body: Container(
        color: Colors.grey[300], // Set background color to light gray
        child: Column(
          children: [
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}