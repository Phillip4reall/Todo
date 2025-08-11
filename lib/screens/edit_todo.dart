
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/model/models.dart';
import 'package:todo/providers/todo_riverpod.dart';

class EditTodo extends ConsumerStatefulWidget {
  final Todo todo;

  const EditTodo({super.key, required this.todo});

  @override
  ConsumerState<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends ConsumerState<EditTodo> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.title);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateTodo() {
    final newTitle = _controller.text.trim();
    if (newTitle.isNotEmpty) {
      ref.read(todoListProvider.notifier).updateTodo(
        widget.todo.id,
        newTitle,
      );
      Navigator.pop(context); // Go back after update
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Todo", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Text('Click to edit the todo',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w300),),
             //const SizedBox(height: 10),
            const SizedBox(height: 30,),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Edit your todo',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _updateTodo(),
            ),
            const SizedBox(height: 20),
           
            Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                     child: InkWell(
               onTap: (){
                _updateTodo();
                
              },
                      child: Center(child: Text('Update Todo',style: TextStyle(color: Colors.white,fontSize: 20),),),
                     ),
                  ),
          ],
        ),
      ),
    );
  }
}
