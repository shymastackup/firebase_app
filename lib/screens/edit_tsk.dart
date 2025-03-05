import 'package:backend_project/screens/to_do_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatelessWidget {
  final int index;
  final String task;

  const EditTaskScreen({super.key, required this.index, required this.task});

  @override
  Widget build(BuildContext context) {
    final TextEditingController taskController = TextEditingController(text: task);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Task',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 400),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Edit Task',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.edit, color: Colors.blueAccent),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

           
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (taskController.text.isNotEmpty) {
                    todoProvider.updateTask(index, taskController.text);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                child: const Text(
                  'Update Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
