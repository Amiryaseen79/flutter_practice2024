import 'package:flutter/material.dart';
import 'db_helper.dart'; // Database helper file
import 'model/item.dart'; // Item model file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
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
  String searchQuery = "";
  int? curItemId;
  final formKey = GlobalKey<FormState>();
  late DatabaseHelper dbHelper;
  List<Item> filteredItems = [];

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    searchForItems();
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
      searchForItems();
    }
  }

  void searchForItems() async {
    if (searchQuery.isNotEmpty) {
      filteredItems = await dbHelper.searchItems(searchQuery);
    } else {
      filteredItems = await dbHelper.getItems();
    }
    setState(() {});
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
                backgroundColor: Colors.grey,
              ),
              onPressed: validate,
              child: Text(curItemId == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
          searchForItems();
        },
        decoration: InputDecoration(
          labelText: "Search Items",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
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
              searchForItems();
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
        future: dbHelper.getItems(),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: dataTable(filteredItems.isEmpty ? snapshot.data! : filteredItems),
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
        title: const Text('SQLite CRUD with Search'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Gradient colors
            begin: Alignment.topLeft, // Starting point
            end: Alignment.bottomRight, // Ending point
          ),
        ),
        child: Column(
          children: [
            searchBar(),
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
