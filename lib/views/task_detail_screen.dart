import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: Theme.of(context).textTheme.headlineSmall),
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage('assets/images/images.jpg')),
                Text('Assigned to: Floyd Wilson'),
                Icon(Icons.calendar_today),
                Text('Due date: ${task.date.toString()}'),
              ],
            ),
            TabBar(
              tabs: [Tab(text: 'Overview'), Tab(text: 'Activity')],
            ),
            Text('You need to choose themes for Dribbble shots for March and upload tasks. For help, you can contact @Alex Johnson, he did such...'),
            Text('Subtasks'),
            CheckboxListTile(
              title: Text('Create a content plan for March'),
              value: true,
              onChanged: (bool? value) {},
            ),
            ElevatedButton(
              child: Text('Add a subtask'),
              onPressed: () {},
            ),
            Text('Attachments'),
            // Add attachment widgets here
          ],
        ),
      ),
    );
  }
}