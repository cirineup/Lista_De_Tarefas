import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const todoListKey = 'todo_list';

class TodoRepository {
  
  SharedPreferences? sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final  jsonString = sharedPreferences?.getString(todoListKey) ?? '[]';
    final jsonDecoded = jsonDecode(jsonString) as List;
    
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos) {
    List<Map<String, dynamic>> map = todos.map((x) => x.tojson()).toList();
    final String jsonString = jsonEncode(map);
    sharedPreferences?.setString(todoListKey, jsonString);
  }
}
