import 'package:hive/hive.dart';

class TodosDB {
  List todos = [];
  final box = Hive.box('bloc');

  loadData() {
    var data = box.get('todos');
    if (data != null) {
      todos = data;
    } else {
      todos = [];
    }
  }

  saveData(data) {
    box.put('todos', data);
  }
}
