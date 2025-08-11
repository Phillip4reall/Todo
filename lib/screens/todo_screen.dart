

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_riverpod.dart';
import 'package:todo/screens/edit_todo.dart';
import 'package:todo/widgets/statistics.dart';
import 'package:todo/widgets/todo_filter.dart';
import 'package:todo/widgets/todo_items.dart';

class TodoScreen extends ConsumerStatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  const TodoScreen(this.isDarkMode, this.onThemeToggle, {super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  void _addTodo(String title) {
    if (title.trim().isNotEmpty) {
      ref.read(todoListProvider.notifier).addTodo(title);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTodos = ref.watch(filteredTodosProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Sticky Header with Search and Filters
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 270,

            actions: [
              InkWell(
              onTap: widget.onThemeToggle,
              child: Card
              (margin: EdgeInsets.all(0),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.isDarkMode ? "Light Mode" : "Dark Mode",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              ),
              Spacer(),
    
  ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 90, left: 16, right: 16),
                child: Column(
                  children: [
                    // Search Field
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        hintText: 'Search todos...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: _onSearchChanged,
                    ),
                    const SizedBox(height: 10),
                    const TodoFilters(),
                     const SizedBox(height: 10),
                     Text('Statistics',style: TextStyle(fontSize: 18,color: Colors.white),),
                  TodoStatsWidget(),
                  ],
                ),
              ),
            ),
          ),
       
          // Add Todo Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter todo...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => _addTodo(value),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    child: InkWell(
                      onTap: () => _addTodo(_controller.text),
                      child: const Center(
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Todo List
          filteredTodos.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No todos found',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final todo = filteredTodos[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditTodo(todo: todo)),
                          );
                        },
                        child: TodoItem(todo: todo),
                      );
                    },
                    childCount: filteredTodos.length,
                  ),
                ),
        ],
      ),
    );
  }
}
