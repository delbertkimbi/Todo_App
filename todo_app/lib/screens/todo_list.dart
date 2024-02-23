import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text("Add Todo"),
      ),
    );
  }

  /// Navigate to AddPage
  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => const AddPage());
    Navigator.push(context, route);
  }

  //Fetch data
  Future<void> fetchData() async {
    const url = "http://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final responds = await http.get(uri);
    //Display data
  }
}
