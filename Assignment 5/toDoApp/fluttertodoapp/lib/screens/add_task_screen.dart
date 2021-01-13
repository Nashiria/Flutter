import 'package:flutter/material.dart';
import 'package:fluttertodoapp/models/task_item.dart';
import 'package:fluttertodoapp/models/task_repository.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String taskTitle;
    return SingleChildScrollView(
      child: Container(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (newText) {
                  taskTitle = newText;
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                  onPressed: () {
                    if (taskTitle != null) {
                      Provider.of<TaskRepository>(context, listen: false)
                          .addItem(TaskItem(title: taskTitle, isDone: false,ImportanceColor: Colors.yellow));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlueAccent)
            ],
          ),
        ),
      ),
    );
  }
}
