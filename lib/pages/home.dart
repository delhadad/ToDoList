import 'package:flutter/material.dart';
import 'package:todo_app_duaa/models/todo.dart';
import 'package:todo_app_duaa/utils/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  List<Todo> toDoList = [];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index].isCompleted = !toDoList[index].isCompleted;
    });
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task cannot be empty!"),
        ),
      );
      return;
    }

    setState(() {
      toDoList.add(Todo(
        task: _controller.text,
      ));
      _controller.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task added!")),
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task deleted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Start where you are!',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: toDoList.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet! Add a new task.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (BuildContext context, index) {
                return TodoList(
                  taskName: toDoList[index].task,
                  taskCompleted: toDoList[index].isCompleted,
                  onChanged: (value) => checkBoxChanged(index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add new reminder',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
