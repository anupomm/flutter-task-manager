import 'package:flutter/material.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/ui/widgets/user_profile_banner.dart';

import '../../data/utils/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _titleController.clear();
      _descriptionController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task Added Successfully')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Task Add Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileBanner(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Add New Task',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Subject',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _addNewTaskInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          addNewTask();
                        },
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
