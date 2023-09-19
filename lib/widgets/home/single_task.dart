import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/constants/dummy_tasks.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/widgets/tasks/task_detail_dialog.dart';
import 'package:main_project/utils/constants.dart';
import 'package:main_project/utils/departments.dart';
import 'package:main_project/utils/status.dart';

class SingleTask extends StatelessWidget {
  final int taskIndex;
  final Member user;

  const SingleTask({super.key, required this.taskIndex, required this.user});

  @override
  Widget build(BuildContext context) {
    final task = tasks[taskIndex];
    final Status status = user.department == Department.functional
        ? task.functionalStatus
        : task.functionalStatus;
    Map<String, dynamic> firstData = {
      'attribute': '',
      'data': '',
      'icon': false
    };
    Map<String, dynamic> secondData = {
      'attribute': '',
      'data': '',
      'icon': false
    };

    if (status == Status.open) {
      firstData['attribute'] = 'Plan Month';
      firstData['data'] =
          DateFormat(Constants.monthFormat).format(DateTime(0, task.planningMonth));
      secondData['attribute'] = 'Plan Week';
      secondData['data'] = 'Week ${task.planningWeek.toString()}';
    } else if (status == Status.pending) {
      firstData['icon'] = true;
      firstData['attribute'] = 'Requirements';
      firstData['data'] = task.requirementGiven
          ? const Icon(
              Icons.done_outlined,
              color: Colors.green,
            )
          : const Icon(
              Icons.close_rounded,
              color: Colors.red,
            );
      secondData['icon'] = true;
      secondData['attribute'] = 'Is Technical';
      secondData['data'] = task.isTechnical
          ? const Icon(
              Icons.done_outlined,
              color: Colors.green,
            )
          : const Icon(
              Icons.close_rounded,
              color: Colors.red,
            );
    } else {
      if (!task.isTechnical ||
          (task.functionalStatus == Status.close &&
              task.technicalStatus == Status.close)) {
        secondData['attribute'] = 'Completed at ';
        secondData['data'] = task.completeDate;
      }
      if (!task.isTechnical) {
        firstData['icon'] = true;
        firstData['attribute'] = 'Requirements';
        firstData['data'] = task.requirementGiven
            ? const Icon(
                Icons.done_outlined,
                color: Colors.green,
              )
            : const Icon(
                Icons.close_rounded,
                color: Colors.red,
              );
      } else if (user.department == Department.functional) {
        if (task.technicalStatus == Status.close) {
          firstData['attribute'] = 'Tech Responsible';
          firstData['data'] = task.technicalResponsible!;
        } else {
          firstData['attribute'] = 'Work end at';
          firstData['data'] = task.functionalWorkCompleteDate!;
          secondData['attribute'] = 'Tech Status';
          secondData['data'] = getStatusString(task.technicalStatus!);
        }
      } else {
        if (task.functionalStatus == Status.close) {
          firstData['attribute'] = 'Func Responsible';
          firstData['data'] = task.functionalResponsible;
        } else {
          firstData['attribute'] = 'Work end at';
          firstData['data'] = task.technicalWorkCompleteDate!;
          secondData['attribute'] = 'Func Status';
          secondData['data'] = getStatusString(task.functionalStatus);
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      // padding: EdgeInsets.only(left: 10),
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: getStatusColor(status),
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(8)),
              ),
              width: 10,
              height: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    task.workType,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    task.description,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assign by',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        task.assignBy,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstData['attribute']!,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      firstData['icon']
                          ? firstData['data']
                          : Text(
                              firstData['data'],
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        secondData['attribute']!,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      secondData['icon']
                          ? secondData['data']
                          : Text(
                              secondData['data']!,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created at',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        task.createdAt,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return TaskDetailDialog(
                          task: task,
                          user: user,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
