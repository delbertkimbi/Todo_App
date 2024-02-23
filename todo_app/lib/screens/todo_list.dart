import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Add Todo"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: "Title",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "Description",
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 8,
            minLines: 5,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => const AddPage());
    Navigator.push(context, route);
  }
}
