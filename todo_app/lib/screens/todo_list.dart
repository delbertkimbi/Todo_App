import 'dart:convert';

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

  bool isLoading = false;
  List items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text("Add Todo"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: fetchData,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items as Map;
                  final id = item['_id'] as String;
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: item['title'],
                    subtitle: item['description'],

                    ///PopUp Menu
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          // Go to edit page
                        } else if (value == 'delte') {
                          //Go to delete page
                          deleteById(id);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text("Edit"),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text("delete"),
                          ),
                        ];
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }

  /// Navigate to AddPage
  void navigateToAddPage() {
    final route = MaterialPageRoute(builder: (context) => const AddPage());
    Navigator.push(context, route);
  }

  Future<void> deleteById(String id) async {
    // delete the item
    final url = "http://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final responds = await http.delete(uri);
    if (responds.statusCode == 200) {
      // Remove the item form the list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {}
  }

  //Fetch data
  Future<void> fetchData() async {
    const url = "http://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final responds = await http.get(uri);
    if (responds.statusCode == 200) {
      final json = jsonDecode(responds.body) as Map;
      final result = json["items"] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
    //Display data
  }
}
