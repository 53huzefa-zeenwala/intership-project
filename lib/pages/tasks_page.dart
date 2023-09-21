import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/widgets/custom_fields/csv_file_input.dart';
// import 'package:main_project/widgets/home/single_task.dart';
import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/layouts/filter_dialog.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';
import 'package:main_project/constants/dummy_tasks.dart';
import 'package:main_project/widgets/tasks/task_detail_dialog.dart';
import 'package:main_project/models/task_model.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/utils/status.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  String sortBy = 'Inc';
  String sortTo = 'Created At';
  String funcStatus = 'All';
  String techStatus = 'All';
  String workType = 'Every';
  late List<Task> allTasks;

  void generateTasks(List<List> data) {
    try {
      List<Task> newTasks = [];

      List header = data[0];
      var remainData = data.skip(1);
      for (var data in remainData) {
        newTasks.add(Task.fromCSV(data, header));
      }
      setState(() {
        allTasks.addAll(newTasks);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allTasks = tasks;
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Heading
            PageHeading(
              title: 'All Tasks',
              button: CsvFileInput(
                upload: generateTasks,
              ),
            ),

            // Filter to control tasks
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).primaryColorLight, width: 2),
                    ),
                    width: 320,
                    height: 45,
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            isExpanded: true,
                            padding: const EdgeInsets.only(left: 10),
                            borderRadius: BorderRadius.circular(8),
                            value: 'Description',
                            items: ['Description', 'Assign by', 'Assign to']
                                .map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            }).toList(),
                            onChanged: (Object? val) => {},
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(8)),
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(8)),
                                  borderSide: BorderSide.none),
                              fillColor:
                                  Theme.of(context).colorScheme.onTertiary,
                              focusColor: Colors.grey.shade50,
                              hoverColor: Colors.grey.shade50,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.merge(
                                      TextStyle(color: Colors.grey.shade500)),
                              filled: true,
                              hintText: 'Search here',
                            ),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Row(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 45,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(8),
                            ),
                            color: Theme.of(context).primaryColorLight,
                          ),
                          child: DropdownButton(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                              alignment: Alignment.center,
                              isExpanded: true,
                              padding: const EdgeInsets.only(left: 10),
                              value: sortTo,
                              underline: Container(),
                              items: ['Created At', 'Completed At'].map((val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() => sortTo = val!);
                              }),
                        ),
                        IconButton(
                            tooltip:
                                sortBy == 'Inc' ? 'Increasing' : 'Decreasing',
                            style: IconButton.styleFrom(
                              fixedSize: const Size(15, 45),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8),
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                            ),
                            onPressed: () {
                              setState(() =>
                                  sortBy = sortBy == 'Inc' ? 'Dec' : 'Inc');
                            },
                            icon: Icon(
                              sortBy == 'Inc'
                                  ? Icons.arrow_downward_rounded
                                  : Icons.arrow_upward_rounded,
                            )),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.filter_list_rounded,
                              color: Colors.black),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FilterDialog(
                                  height: 400,
                                  filters: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    // direction: Axis.horizontal,
                                    // runAlignment: WrapAlignment.end,
                                    children: [
                                      Filter(
                                        title: 'Technical Status',
                                        dropItems: const [
                                          'All',
                                          'Open',
                                          'Pending',
                                          'Close'
                                        ],
                                        currentValue: funcStatus,
                                        onChange: (val) =>
                                            setState(() => funcStatus = val!),
                                      ),
                                      Filter(
                                        title: 'Functional Status',
                                        dropItems: const [
                                          'All',
                                          'Open',
                                          'Pending',
                                          'Close'
                                        ],
                                        currentValue: techStatus,
                                        onChange: (val) =>
                                            setState(() => techStatus = val!),
                                      ),
                                      Filter(
                                        title: 'Work Type',
                                        dropItems: const [
                                          'Every',
                                          'FMS',
                                          'Attribute',
                                          'CRM',
                                          'SAP'
                                        ],
                                        currentValue: workType,
                                        onChange: (val) =>
                                            setState(() => workType = val!),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                          ),
                          label: Text('Filters',
                              style: Theme.of(context).textTheme.displaySmall),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // tasks Heading
            Container(
              width: 120,
              margin: const EdgeInsets.only(bottom: 2, left: 10, top: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tasks',
                      style: Theme.of(context).textTheme.displayMedium),
                  Text('-', style: Theme.of(context).textTheme.displayMedium),
                  Text(allTasks.length.toString(),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),

            // Tasks
            Container(
              // constraints: BoxConstraints(minWidth: 910),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: allTasks.length,
                itemBuilder: (context, index) {
                  final task = allTasks[index];
                  return DetailTask(task: task);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailTask extends StatelessWidget {
  final Task task;
  const DetailTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final Member person = members[0];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      // padding: EdgeInsets.only(left: 10),
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiary,
        borderRadius: BorderRadius.circular(8),
      ),
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
          detail(context, title: 'Owner', data: task.assignBy),
          detail(context,
              title: 'Team',
              data: task.team == Team.implementation
                  ? 'Implementation'
                  : 'Support',
              width: 110),
          detail(context,
              title: 'Func Response',
              data: task.functionalResponsible,
              width: 105),
          task.isTechnical
              ? detail(
                  context,
                  title: 'Tech Response',
                  data: task.technicalResponsible!,
                  width: 105,
                )
              : detail(context, title: 'Is technical', data: 'False'),
          detail(
            context,
            title: 'Func Status',
            data: getStatusString(task.functionalStatus),
            dataColor: getStatusColor(task.functionalStatus),
            width: 80,
          ),
          task.isTechnical
              ? detail(
                  context,
                  title: 'Tech Status',
                  data: getStatusString(task.technicalStatus!),
                  dataColor: getStatusColor(task.technicalStatus!),
                )
              : task.functionalStatus == Status.close
                  ? detail(context,
                      title: 'Completed At', data: task.completeDate!)
                  : task.functionalStatus == Status.open
                      ? task.planningMonth ==
                              int.tryParse(
                                  DateFormat.M().format(DateTime.now()))
                          ? detail(context,
                              title: 'Plan Week',
                              data: 'Week ${task.planningWeek.toString()}')
                          : detail(
                              context,
                              title: 'Plan Month',
                              data: DateFormat('MMMM').format(
                                DateTime(0, task.planningMonth),
                              ),
                            )
                      : detail(context,
                          title: 'Requirements',
                          data: task.requirementGiven ? 'Yes' : 'No'),
          detail(context, title: 'Created at', data: task.createdAt, width: 80),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => TaskDetailDialog(
                  task: task,
                  user: person,
                ),
              );
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }

  SizedBox detail(BuildContext context,
      {double width = 100,
      required String title,
      required String data,
      Color dataColor = Colors.black}) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Text(
            data,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.merge(TextStyle(color: dataColor)),
          ),
        ],
      ),
    );
  }
}
