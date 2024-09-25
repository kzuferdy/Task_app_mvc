import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/task_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context, taskController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Manage your tasks'),
            actions: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/images.jpg'),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildCalendar(),
              _buildTaskList(taskController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCalendar() {
    // Implement calendar widget here
    return Container(
      height: 100,
      child: Center(child: Text('Calendar Placeholder')),
    );
  }

  Widget _buildTaskList(TaskController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) {
          final task = controller.tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text('${task.date.toString()} - ${task.priority}'),
          );
        },
      ),
    );
  }
}