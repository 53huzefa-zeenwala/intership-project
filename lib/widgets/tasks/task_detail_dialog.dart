import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:main_project/models/task_model.dart';
import 'package:main_project/widgets/layouts/base_dialog.dart';
import 'package:main_project/utils/departments.dart';
import 'package:main_project/utils/status.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/models/member_model.dart';

class TaskDetailDialog extends StatefulWidget {
  final Task task;
  final Member user;
  const TaskDetailDialog({super.key, required this.task, required this.user});

  @override
  State<TaskDetailDialog> createState() => _TaskDetailDialogState();
}

class _TaskDetailDialogState extends State<TaskDetailDialog> {
  late Status userStatus;
  late Task task;
  @override
  void initState() {
    super.initState();
    task = widget.task;
    userStatus = widget.user.department == Department.functional
        ? task.functionalStatus
        : task.technicalStatus!;
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      maxWidth: 900,
      title: task.workType,
      mainFunction: () {
        context.go('/tasks/${task.id}');
      },
      displayData: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description', style: Theme.of(context).textTheme.bodyMedium),
            Text(task.description,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 10,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsibleDetails(
                          title: 'Functional',
                          responsible: task.functionalResponsible,
                          status:
                              widget.user.department == Department.functional
                                  ? userStatus
                                  : task.functionalStatus,
                          remark: task.functionalRemark ?? '-',
                          userDepartment: widget.user.department,
                          onChange: (val) {
                            if (widget.user.department ==
                                Department.functional) {
                              setState(() {
                                userStatus = val!;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        task.isTechnical
                            ? ResponsibleDetails(
                                title: 'Technical',
                                responsible: task.technicalResponsible!,
                                status: widget.user.department ==
                                        Department.technical
                                    ? userStatus
                                    : task.technicalStatus!,
                                remark: task.technicalRemark ?? '-',
                                userDepartment: widget.user.department,
                                onChange: (val) {
                                  if (widget.user.department ==
                                      Department.technical) {
                                    setState(() {
                                      userStatus = val!;
                                    });
                                  }
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  TaskMinorDetails(task: task),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TaskMinorDetails extends StatelessWidget {
  final Task task;
  const TaskMinorDetails({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(width: 1),
        ),
      ),
      padding: const EdgeInsets.only(left: 10),
      constraints: const BoxConstraints(maxHeight: 250, minHeight: 180),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          details(context, title: 'Assign By', data: task.assignBy),
          details(context,
              title: 'Team',
              data: task.team == Team.implementation
                  ? 'Implementation'
                  : 'Support'),
          details(context,
              title: 'Requirements Given',
              data: task.requirementGiven ? 'YES' : 'NO'),
          details(context, title: 'Created At', data: task.createdAt),
          task.completeDate != null
              ? details(context,
                  title: 'Completed At', data: task.completeDate!)
              : details(context,
                  title: 'Planned Month',
                  data: DateFormat('MMMM')
                      .format(DateTime(0, task.planningMonth))),
          task.completeDate != null
              ? const SizedBox()
              : details(context,
                  title: 'Planned Week', data: 'Week ${task.planningWeek}')
        ],
      ),
    );
  }

  Padding details(BuildContext context,
      {required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child:
                  Text(title, style: Theme.of(context).textTheme.displaySmall),
            ),
            Text(
              data,
              style: Theme.of(context).textTheme.labelSmall,
            )
          ]),
    );
  }
}

class ResponsibleDetails extends StatelessWidget {
  final String title;
  final String responsible;
  final Status status;
  final String remark;
  final Department userDepartment;
  final Function(Status?) onChange;

  const ResponsibleDetails({
    super.key,
    required this.title,
    required this.responsible,
    required this.status,
    required this.remark,
    required this.userDepartment,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder dropdownBorder(status) => OutlineInputBorder(
        borderSide: BorderSide(
          color: getStatusColor(status),
        ),
        borderRadius: BorderRadius.circular(4));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 5),
        detail(
          context,
          title: 'Responsible',
          data: responsible,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Container(
                width: 90,
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  'Status',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              (title == 'Functional' &&
                          userDepartment == Department.functional) ||
                      (title == 'Technical' &&
                          userDepartment == Department.technical)
                  ? SizedBox(
                      height: 30,
                      width: 120,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onTertiary,
                          contentPadding: const EdgeInsets.only(left: 10),
                          border: dropdownBorder(status),
                          enabledBorder: dropdownBorder(status),
                          focusedBorder: dropdownBorder(status),
                        ),
                        borderRadius: BorderRadius.circular(4),
                        value: status,
                        items: Status.values.map((Status item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              getStatusString(item),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.merge(
                                      TextStyle(color: getStatusColor(item))),
                            ),
                          );
                        }).toList(),
                        onChanged: onChange,
                      ))
                  : Text(
                      getStatusString(status),
                      style: Theme.of(context).textTheme.labelSmall?.merge(
                            TextStyle(color: getStatusColor(status)),
                          ),
                    )
            ],
          ),
        ),
        detail(context, title: 'Remark', data: remark),
      ],
    );
  }

  Row detail(BuildContext context,
      {required String title, required String data}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 90,
          margin: const EdgeInsets.only(right: 15),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        Expanded(
          child: Text(data,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context).textTheme.labelSmall),
        )
      ],
    );
  }
}
