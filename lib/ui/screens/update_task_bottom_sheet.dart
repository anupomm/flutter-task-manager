
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/response_object.dart';

import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
class UpdateTaskBottomSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskBottomSheet({super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskBottomSheet> createState() => _UpdateTaskBottomSheetState();
}

class _UpdateTaskBottomSheetState extends State<UpdateTaskBottomSheet> {
  late TextEditingController _titleTEController;

  late TextEditingController _descriptionTEController;

  bool _updatetaskInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    _titleTEController = TextEditingController(text: widget.task.title);
    _descriptionTEController =
        TextEditingController(text: widget.task.description);

    super.initState();
  }

  Future<void> updateTask() async {
    _updatetaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _updatetaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if(response.isSuccess){
      _titleTEController.clear();
      _descriptionTEController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task updated Successfully')));
      }
      widget.onUpdate();
    }
    else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
        Text('Task update Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Update Task',
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
                controller: _titleTEController,
                decoration: const InputDecoration(
                  hintText: 'Subject',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 5,
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
                  visible: _updatetaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () {
                      updateTask();
                    },
                    child: const Text('Update'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
