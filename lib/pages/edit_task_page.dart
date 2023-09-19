import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:main_project/constants/dummy_tasks.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';
import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/snack_bar.dart';
import 'package:main_project/widgets/tasks/form.dart';
import 'package:main_project/models/task_model.dart';

class EditTaskPage extends StatelessWidget {
  final String? taskId;
  const EditTaskPage({super.key, Task? task, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final List<String> functionalMembers = ['anshul', 'Jay', 'Cololn'];
    final List<String> technicalMembers = ['anshul', 'Jay', 'Cololn', 'gross'];
    final List<String> workTypes = ['sap', 'ax', 'asccadc'];

    if (taskId == null|| tasks.indexWhere((element) => element.id == taskId) == -1) {
      context.pop();
      return Scaffold(
        body: Center(
            child: Text('Page Not found',
                style: Theme.of(context).textTheme.bodyLarge)),
      );
    }

    final Task task = tasks.firstWhere((task) => task.id == taskId);
    return BaseLayout(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const PageHeading(title: 'Update task'),
            Form(
              key: formKey,
              child: TaskForm(
                  task: task,
                  formKey: formKey,
                  functionalMembers: functionalMembers,
                  technicalMembers: technicalMembers,
                  workTypes: workTypes,
                  formType: 'Update',
                  addTask: (task) {}),
            )
          ],
        ),
      ),
    );
  }
}
