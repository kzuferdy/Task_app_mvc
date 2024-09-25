import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  String _priority = 'Low';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
        leading: TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            child: Text('Done'),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value ?? '',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value ?? '',
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Due date'),
                    readOnly: true,
                    controller: TextEditingController(text: _dueDate.toString()),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _dueDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) setState(() => _dueDate = date);
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Estimate task'),
                    initialValue: '3h',
                  ),
                ),
              ],
            ),
            Row(
              children: ['Low', 'Medium', 'High'].map((String value) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(value),
                    value: value,
                    groupValue: _priority,
                    onChanged: (String? newValue) {
                      setState(() => _priority = newValue!);
                    },
                  ),
                );
              }).toList(),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Members'),
              items: ['Dianne Russell'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final task = Task(title: _title, date: _dueDate, priority: _priority);
      TaskController().addTask(task);
      Navigator.pop(context);
    }
  }
}