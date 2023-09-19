import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';
import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/snack_bar.dart';
import 'package:main_project/widgets/tasks/form.dart';
import 'package:main_project/models/task_model.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/utils/status.dart';
class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key, Task? task});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final List<String> functionalMembers = ['anshul', 'Jay', 'Cololn'];
    final List<String> technicalMembers = ['anshul', 'Jay', 'Cololn', 'gross'];
    final List<String> workTypes = ['sap', 'ax', 'asccadc'];
    final String taskId = DateTime.now().millisecondsSinceEpoch.toString();

    final Task task = Task(
        id: taskId,
        workType: '',
        description: '',
        assignBy: '',
        team: Team.implementation,
        createdAt: '',
        requirementGiven: false,
        isTechnical: false,
        planningMonth: 4,
        planningWeek: 1,
        functionalResponsible: '',
        functionalStatus: Status.open);

    return BaseLayout(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const PageHeading(title: 'Add task'),
            Form(
              key: formKey,
              child: TaskForm(
                  task: task,
                  formKey: formKey,
                  functionalMembers: functionalMembers,
                  technicalMembers: technicalMembers,
                  workTypes: workTypes,
                  formType: 'New',
                  addTask: (task) {
                    ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: AlertSnackBar(
                                  message:
                                      'Task added successfully!, changes will be display to work responsible soon.',
                                  type: AlertType.success,
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                width: 360,
                              ),
                            );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
