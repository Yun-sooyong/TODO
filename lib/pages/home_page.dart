import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_with_youtube_video/data/database.dart';
import 'package:todo_list_with_youtube_video/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the box
  final _box = Hive.box('todoBox');
  TodoData db = TodoData();

  @override
  void initState() {
    // If this is the 1st time ever opening the app, then create default data
    if (_box.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // already exist data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  TextEditingController _controller = TextEditingController();

  // tap the checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  // create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (cotext) {
          return AlertDialog(
            title: const Text('Add a new task'),
            content: TextField(
              controller: _controller,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  saveNewTask();
                },
                child: const Text('save'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('cancel'),
              ),
            ],
          );
        });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0],
            isTaskCompleted: db.todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
