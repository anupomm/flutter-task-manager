import 'package:flutter/material.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';
import 'add_new_task_screen.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserProfileBanner(),
            const Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'New Task',
                    number: 10,
                  ),
                ),
                Expanded(
                  child: SummaryCard(
                    title: 'Completed',
                    number: 5,
                  ),
                ),
                Expanded(
                  child: SummaryCard(
                    title: 'Cancelled',
                    number: 16,
                  ),
                ),
                Expanded(
                  child: SummaryCard(
                    title: 'Progress',
                    number: 12,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return TaskListTile();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
