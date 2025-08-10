// Model
// lib/models/todo.dart

class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // This is the key method for immutable updates
  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Todo && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
     return {
       'id': id,
      'title': title,
       'completed': isCompleted,
    };
  }
   factory Todo.fromJson(Map<String, dynamic> json) {
     return Todo(
       id: json['id'],
       title: json['title'],
       isCompleted: json['isCompleted'] ?? false,
     );
   
}
}
// class Todo {
//   final String id;
//   final String title;
//   final bool completed;

//   Todo({
//     required this.id,
//     required this.title,
//     this.completed = false,
//   });

//   Todo copyWith({String? id, String? title, bool? completed, required bool isCompleted}) {
//     return Todo(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       completed: completed ?? this.completed,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'completed': completed,
//     };
//   }

//   factory Todo.fromJson(Map<String, dynamic> json) {
//     return Todo(
//       id: json['id'],
//       title: json['title'],
//       completed: json['completed'] ?? false,
//     );
//   }
// }
