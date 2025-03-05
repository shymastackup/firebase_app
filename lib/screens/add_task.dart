import 'package:backend_project/screens/delete_tsk.dart';
import 'package:backend_project/screens/edit_tsk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_project/screens/to_do_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();
  final int? taskIndex;
  final String? existingTask;

  AddTaskScreen({super.key, this.taskIndex, this.existingTask}) {
    if (existingTask != null) {
      taskController.text = existingTask!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'taskTitle',
          child: Text(
            existingTask != null ? 'Edit Task' : 'Add Task',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: existingTask != null ? 'Edit task' : 'Enter task',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: () {
                      taskController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      if (existingTask == null) {
                        todoProvider.addTask(taskController.text); 
                      } else {
                        todoProvider.updateTask(taskIndex!, taskController.text); 
                      }
                      Navigator.pop(context);
                    }
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      existingTask != null ? Icons.update : Icons.add,
                      key: ValueKey<bool>(existingTask != null),
                    ),
                  ),
                  label: Text(existingTask != null ? 'Update Task' : 'Add Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

             
              if (existingTask != null)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  EditTaskScreen(index: taskIndex!, task: existingTask!),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Task'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showDeleteConfirmation(context, taskIndex!);
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete Task'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }


  void _showDeleteConfirmation(BuildContext context, int taskIndex) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Delete",
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you want to delete this task?"),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          DeleteTaskScreen(taskIndex),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
