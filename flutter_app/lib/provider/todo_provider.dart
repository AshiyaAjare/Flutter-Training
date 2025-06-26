import 'package:flutter/widgets.dart';
import 'package:todo_app/model/todo.dart';

class ToDoProvider with ChangeNotifier {
  List<ToDo> _todos = [];
  List<ToDo> get allTodos => _todos;
  int get todoCount => _todos.length;

  String _searchQuery = '';

  List<ToDo> get filteredTodos {
    if (_searchQuery.isEmpty) {
      return _todos;
    } else {
      return _todos
          .where((todo) =>
              todo.todoText!.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  void addToDo(ToDo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeToDo(ToDo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void toggleToDoStatus(ToDo todo){
    int index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index].isDone = !_todos[index].isDone;
      notifyListeners();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}