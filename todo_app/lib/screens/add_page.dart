import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("Add Todo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// FORM
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
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
            onPressed: () {
              summitData();
              return Navigator.pop();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  /// HANDLE FORM
  Future<void> summitData() async {
    //Get dat from form
    final title = titleController.text;
    final description = descriptionController.text;
    //Post gotten info
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //Submit data to the server
    //post api call
    const url = "http://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final responds = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    //Show success or failed message depending on the status
    if (responds.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("Added Succesfully");
    } else {
      showErrorMessage("Creation faild");
    }
  }

  // API responds reaction
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
