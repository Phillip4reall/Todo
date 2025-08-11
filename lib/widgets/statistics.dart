
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_riverpod.dart';

class TodoStatsWidget extends ConsumerWidget {
  const TodoStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(todoStatsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatBox("Total", stats.total, Colors.blue),
          _buildStatBox("Active", stats.active, Colors.orange),
          _buildStatBox("Completed", stats.completed, Colors.green),
          
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.white,)),
      ],
    );
  }
}
