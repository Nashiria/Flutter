import 'models/task_repository.dart';
import 'screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<TaskRepository>(
    create: (context) => TaskRepository(),
    child: MaterialApp(
      home: MainScreen(),
    ),
  ));
}
