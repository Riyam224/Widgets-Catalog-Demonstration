import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // ✅ import rootBundle

class TodayTodoList extends StatefulWidget {
  const TodayTodoList({super.key});

  @override
  State<TodayTodoList> createState() => _TodayTodoListState();
}

class _TodayTodoListState extends State<TodayTodoList> {
  List<dynamic> tasks = [];

  // ✅ Load JSON from assets
  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => loadJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today's To-Do List")),
      body: tasks.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return CheckboxListTile(
                  title: Text(task["task"]),
                  value: task["done"],
                  onChanged: (val) {
                    setState(() {
                      task["done"] = val;
                    });
                  },
                );
              },
            ),
    );
  }
}
