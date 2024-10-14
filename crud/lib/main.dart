import 'package:flutter/material.dart';
import 'db_helper.dart'; // Database helper file
import 'model/item.dart'; // Item model file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD with Gradient',
      debugShowCheckedModeBanner: false,
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
  int? curItemId;
  final formKey = GlobalKey<FormState>();
  late DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    refreshList();
  }

  refreshList() {
    setState(() {
      items = dbHelper.getItems();
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
        dbHelper.insertItem(Item(name: name));
      } else {
        dbHelper.updateItem(Item(id: curItemId, name: name));
      }
      clearName();
      refreshList();
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
          ],
        ),
      ),
    );
  }

  dataTable(List<Item> items) {
    return DataTable(
      columns: const [
        DataColumn(
          label: Center(
            child: Text('Name'),
          ),
        ),
        DataColumn(
          label: Center(
            child: Text('Delete'),
          ),
        ),
      ],
      rows: items
          .map(
            (item) => DataRow(cells: [
          DataCell(
            Center(
              child: Text(item.name),
            ),
            onTap: () {
              setState(() {
                curItemId = item.id;
                controller.text = item.name;
              });
            },
          ),
          DataCell(
            Center(
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  dbHelper.deleteItem(item.id!);
                  refreshList();
                },
              ),
            ),
          ),
        ]),
      )
          .toList(),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: dbHelper.getItems(),
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
        title: const Text('SQLite CRUD with Gradient Background'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Starting point of the gradient
            end: Alignment.bottomRight, // Ending point of the gradient
            colors: [
              Colors.blue, // First color (top left)
              Colors.purple, // Second color (bottom right)
            ],
          ),
        ),
        child: Column(
          children: [
            form(),
            list(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          validate();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
