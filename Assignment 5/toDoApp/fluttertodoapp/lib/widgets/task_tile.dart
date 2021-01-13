import 'package:flutter/material.dart';


class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final Color Importance;
  final Function onCheckboxClicked;
  final Function onLongPress;
  const TaskTile({
    this.title,
    this.Importance,
    this.isDone,
    this.onCheckboxClicked,
    this.onLongPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Text(
        this.title,
        style: TextStyle(
          color: Colors.lightBlueAccent,
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isDone,
        activeColor: Colors.lightBlueAccent,
        onChanged: onCheckboxClicked,
      ),
    );
  }
}
