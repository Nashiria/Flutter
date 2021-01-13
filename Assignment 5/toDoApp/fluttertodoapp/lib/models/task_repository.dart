import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';
import 'task_item.dart';





class TaskRepository extends ChangeNotifier {
  List<TaskItem> tasks = [];
  SharedPreferences sharedPreferences;

  _TaskRepository() {

    loadSharedPreferencesAndData();
    loadData();
    tasks.add(TaskItem(title: "Buy bread",isDone: true,ImportanceColor: Colors.red));
    tasks.add(TaskItem(title: "Study CET 301", isDone: true,ImportanceColor: Colors.red));
    tasks.add(TaskItem(title: "watch  film", isDone: true,ImportanceColor: Colors.blue));


  }
  int taskCount() {
    return tasks.length;
  }

  int incompleteTaskCount() {
    return tasks.where((t) => !t.isDone).length;
  }
  Future<void>LoadData()async{
    List<TaskItem> New=await Load();
    for(int i=0;i<New.length;i++){
      tasks.add(New[i]);


    }

  }
  Load()  {

    List<String> Tasks=[];
    List<String> Importance=[];
    List<String> Done=[];
    if(sharedPreferences.containsKey("Tasks")){
      List<String> Tasks=sharedPreferences.getStringList("Tasks");
      List<String> Importance=sharedPreferences.getStringList("Importance");
      List<String> Done=sharedPreferences.getStringList("Done");


    }

    List<TaskItem> TaskClassList;
    for(int i=0;i<Tasks.length;i++){
      var returnColor=Colors.white;
      bool isDone;
      if(Importance[i]==Colors.red.toString()){returnColor=Colors.red;}
      if(Importance[i]==Colors.yellow.toString()){returnColor=Colors.yellow;}
      if(Importance[i]==Colors.blue.toString()){returnColor=Colors.blue;}
      if(Importance[i]==Colors.green.toString()){returnColor=Colors.green;}
      if(Done[i]==true.toString()){isDone=true;}
      else{isDone=false;}
      TaskItem CurrentTask;
      CurrentTask.title=Tasks[i];
      CurrentTask.isDone=isDone;
      CurrentTask.ImportanceColor=returnColor;
      TaskClassList.add(CurrentTask);
    }

    tasks=TaskClassList;
  }
  void addItem(TaskItem item){
    // Insert an item into the top of our list, on index zero
    tasks.add(item);
    print(tasks.length);

    saveData();
    notifyListeners();
  }

  void changeItemCompleteness(TaskItem item){

    item.isDone = !item.isDone;
    notifyListeners();
  }


  void editItem(TaskItem item ,String title){
    item.title = title;
    saveData();
    notifyListeners();
  }

  void removeItem(TaskItem item){
    tasks.remove(item);
    saveData();
    notifyListeners();
  }

  void loadData() {

    List<String> Tasknames = sharedPreferences.getStringList('Tasknames');
    List<String>  ImportanceColors = sharedPreferences.getStringList('ImportanceColors');
    List<String>  isDones = sharedPreferences.getStringList('isDones');
    for(int i=0;i<Tasknames.length;i++){
      bool done=true;
      if(isDones[i].toString()==true.toString()){done=true;}
      else{done=false;}
      Color Target=Colors.red;
      if(ImportanceColors[i].toString()==Colors.red.toString()){Target=Colors.red;}
      if(ImportanceColors[i].toString()==Colors.blue.toString()){Target=Colors.blue;}
      if(ImportanceColors[i].toString()==Colors.green.toString()){Target=Colors.green;}
      if(ImportanceColors[i].toString()==Colors.yellow.toString()){Target=Colors.yellow;}
      else{Target=Colors.white;}
      tasks.add(TaskItem(title: Tasknames[i],ImportanceColor: Target,isDone: done));

    }
    notifyListeners();
  }

  void saveData(){
    List<String> Tasknames;
    List<String>  ImportanceColors;
    List<String>  isDones;
    for(int i=0;i<tasks.length;i++){
      Tasknames.add(tasks[i].title);
      isDones.add(tasks[i].isDone.toString());
      ImportanceColors.add(tasks[i].ImportanceColor.toString());
    }
    sharedPreferences.setStringList('Tasknames', Tasknames);
    sharedPreferences.setStringList('ImportanceColors', ImportanceColors);
    sharedPreferences.setStringList('isDones', isDones);
    print(tasks.length);
    notifyListeners();
  }
  void loadSharedPreferencesAndData() async {

    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
    notifyListeners();
  }
}

