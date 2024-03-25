import 'package:flutter/material.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/updateTaskStatusSheet.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_banner.dart';
import 'add_new_task_screen.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getProgressTaskInProgress = false;
  TaskListModel _progressTaskListModel = TaskListModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProgressTasks();
    });
  }

  Future<void> getProgressTasks() async {
    _getProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.progressListTasks);

    if (response.isSuccess) {
      _progressTaskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Progress task list data get failed')));
      }
    }
    _getProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      _progressTaskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileBanner(),
            const SizedBox(height: 8,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getProgressTasks();
                },
                child: _getProgressTaskInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _progressTaskListModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTile(
                            data: _progressTaskListModel.data![index],
                            onDeleteTap: () {
                              deleteTask(_progressTaskListModel.data![index].sId!);
                            },
                            onEditTap: () {
                              showStatusUpdateBottomSheet(_progressTaskListModel.data![index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
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

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getProgressTasks();
        });
      },
    );
  }
}
