//Riverpod 
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/models.dart';


// 1. StateNotifierProvider for complex state (todo list)
class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

   static const String _prefsKey = 'todos';

   //
   
//
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString(_prefsKey);
    if (todosJson != null) {
      final List<dynamic> decoded = jsonDecode(todosJson);
      state = decoded.map((item) => Todo.fromJson(item)).toList();
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String todosJson = jsonEncode(state.map((todo) => todo.toJson()).toList());
    await prefs.setString(_prefsKey, todosJson);
  }

   void addTodo(String title) {
    if (title.trim().isEmpty) return;
    
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );
    
    // Key concept: Create new state, don't modify existing
    state = [...state, newTodo];
    _saveTodos();
    //state= state.
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
     _saveTodos();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
     _saveTodos();
  }

  // void clearCompleted() {
  //   state = state.where((todo) => !todo.isCompleted).toList();
  // }

  void updateTodo(String id, String newTitle) {
  state = [
    for (final todo in state)
      if (todo.id == id)
        todo.copyWith(title: newTitle)
      else
        todo,
  ];
  _saveTodos();
}
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier()..loadTodos();
});

// 2. StateProvider for simple state (filter)
enum TodoFilter { all, active, completed }

final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);
final searchQueryProvider = StateProvider<String>((ref) => '');
// 3. Provider for computed values (filtered todos)
// final filteredTodosProvider = Provider<List<Todo>>((ref) {
//   final todos = ref.watch(todoListProvider);
//   final filter = ref.watch(todoFilterProvider);
//    final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

//   switch (filter) {
//     case TodoFilter.all:
//       return todos;
//     case TodoFilter.active:
//       return todos.where((todo) => !todo.isCompleted).toList();
//     case TodoFilter.completed:
//       return todos.where((todo) => todo.isCompleted).toList();
//   }
//    // Apply search query
// });
final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoListProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  List<Todo> filtered = todos;

  // Apply filter (Active / Completed / All)
  switch (filter) {
    case TodoFilter.active:
      filtered = todos.where((todo) => !todo.isCompleted).toList();
      break;
    case TodoFilter.completed:
      filtered = todos.where((todo) => todo.isCompleted).toList();
      break;
    case TodoFilter.all:
    break;
  }

  // Apply search query
  if (searchQuery.isNotEmpty) {
    filtered = filtered
        .where((todo) => todo.title.toLowerCase().contains(searchQuery))
        .toList();
  }

  return filtered;
});


// 4. Provider for statistics (computed values)
final todoStatsProvider = Provider<TodoStats>((ref) {
  final todos = ref.watch(todoListProvider);
  
  final total = todos.length;
  final completed = todos.where((todo) => todo.isCompleted).length;
  final active = total - completed;
  
  return TodoStats(
    total: total,
     active: active,
    completed: completed,
   
  );
});

class TodoStats {
  final int total;
  final int active;
  final int completed;
  

  TodoStats({
    required this.total,
    required this.completed,
    required this.active,
  });

  
}
