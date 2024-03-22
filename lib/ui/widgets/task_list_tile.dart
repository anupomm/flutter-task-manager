import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Task'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('This is task description'),
          const SizedBox(height: 8,),
          const Text('Date'),
          Row(
            children: [
              const Chip(
                label: Text(
                  'New',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.edit, color: Colors.green,),
              ),
              IconButton(
                onPressed: () {
                },
                icon: Icon(Icons.delete_forever, color: Colors.red.shade300,),
              ),
            ],
          )
        ],
      ),
    );
  }
}
