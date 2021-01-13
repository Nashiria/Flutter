import 'package:fluttertodoapp/models/task_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class TaskList extends StatelessWidget {
  const TaskList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskRepository>(
      builder: (context, taskRepository, child) {
        return ListView.builder(
            itemCount: taskRepository.taskCount(),
            itemBuilder: (context, index) {
              var task = taskRepository.tasks[index];
              IconData TrueIcon=Icons.check_box;
              IconData FalseIcon=Icons.check_box_outline_blank;
              IconData CurrentIcon;
              List<IconData> truefalse=[];
              truefalse.add(TrueIcon);
              truefalse.add(FalseIcon);

              if(task.isDone=true){CurrentIcon=TrueIcon;}
              else{CurrentIcon=FalseIcon;}
              return ListTile(
                leading: Icon(Icons.album_sharp,color: task.ImportanceColor,size:40),
                title: Text(task.title),
                trailing:Icon(CurrentIcon),
                onTap: () {
                  taskRepository.changeItemCompleteness(task);
                },

                onLongPress:  () async {
                  if (Platform.isIOS)
                    await showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure to delete ${task.title}?\nThis action is unreversible!'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Yes'),
                              onPressed: () {

                                taskRepository.removeItem(task);
                                Navigator.of(context).pop();

                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  else {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure to delete ${task.title}?\nThis action is unreversible!'),
                          actions: [
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                taskRepository.removeItem(task);
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                  }
                },
              );
            });
      },
    );
  }
}
