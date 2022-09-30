import 'package:hive_flutter/hive_flutter.dart';

class TodoData {
  // todo task List
  List todoList = [];

  // reference box
  final _box = Hive.box('todoBox');

  // 앱이 설치되고 최초 1회만 실행되는 함수
  void createInitialData() {
    todoList = [
      ['Your To Do App', false],
      ['you can delete task to slide task container', false],
    ];
  }

  // load data
  void loadData() {
    todoList = _box.get('TODOLIST');
  }

  // update data
  void updateDataBase() {
    _box.put('TODOLIST', todoList);
  }
}
