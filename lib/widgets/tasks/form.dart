import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/widgets/base_input_widget/base_view.dart';
import 'package:main_project/widgets/custom_button/primary_button.dart';
import 'package:main_project/widgets/custom_fields/custom_date_picker.dart';
import 'package:main_project/widgets/custom_fields/custom_dropdown.dart';
import 'package:main_project/widgets/custom_fields/textfield/normal_textfield.dart';
import 'package:main_project/models/task_model.dart';
import 'package:main_project/utils/constants.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/utils/status.dart';

class TaskForm extends StatefulWidget {
  final Task task;
  final GlobalKey<FormState> formKey;
  final List<String> functionalMembers;
  final List<String> technicalMembers;
  final List<String> workTypes;
  final String formType;
  final Function(Task) addTask;

  const TaskForm({
    super.key,
    required this.task,
    required this.formKey,
    required this.functionalMembers,
    required this.technicalMembers,
    required this.workTypes,
    required this.formType,
    required this.addTask,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  bool multipleTask = false;
  late bool isTechnical;
  late bool isRequirementGiven;
  late String taskDescription;
  late Status functionalStatus;
  late Status? technicalStatus;
  late Task task;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    task = widget.task;
    isTechnical = task.isTechnical;
    isRequirementGiven = task.requirementGiven;
    taskDescription = task.description;
    functionalStatus = task.functionalStatus;
    technicalStatus = task.technicalStatus;
  }

  @override
  Widget build(BuildContext context) {
    final weeks = List.generate(5, (i) => '${i + 1} Week');
    final List<String> statusList = Status.values.map((element) {
      return getStatusString(element);
    }).toList();

    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return Column(
      children: [
        InputContainer(
          child: Column(children: [
            InputFrame(
              title: 'Starting Date',
              remark: 'Automatically Selected, Day of Task Created.',
              inputField: CustomDatePicker(
                onSaved: (val) => task.createdAt =
                    DateFormat(Constants.dateFormat)
                        .format(val ?? DateTime.now()),
                defaultValue: task.createdAt.isEmpty
                    ? DateTime.now()
                    : DateFormat(Constants.dateFormat).parse(task.createdAt),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please assign starting date of task.';
                  }
                  return null;
                },
              ),
            )
          ]),
        ),
        InputContainer(
            child: Column(
          children: [
            InputFrame(
              title: 'Functional responsible',
              inputField: CustomDropDown(
                dropItems: widget.functionalMembers,
                labelText: '',
                isEnable: true,
                defaultValue: task.functionalResponsible.isNotEmpty &&
                        widget.functionalMembers
                            .contains(task.functionalResponsible)
                    ? task.technicalResponsible
                    : widget.functionalMembers[0],
                onSaved: (newValue) => task.functionalResponsible = newValue!,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please assign functional responsible';
                  }
                  if (!widget.functionalMembers.contains(val)) {
                    return 'Function Responsible not found';
                  }
                  return null;
                },
              ),
            ),
            InputFrame(
                title: 'Is technical',
                inputField: Checkbox(
                  value: isTechnical,
                  onChanged: (value) => setState(() => isTechnical = value!),
                )),
            InputFrame(
              title: 'Technical responsible',
              inputField: CustomDropDown(
                dropItems: widget.technicalMembers,
                labelText: '',
                defaultValue: isTechnical
                    ? task.technicalResponsible != null &&
                            (task.technicalResponsible!.isNotEmpty &&
                                widget.technicalMembers
                                    .contains(task.technicalResponsible))
                        ? task.technicalResponsible
                        : widget.functionalMembers[0]
                    : null,
                isEnable: isTechnical,
                onSaved: (newValue) =>
                    task.technicalResponsible = isTechnical ? newValue! : null,
                validator: (val) {
                  if (isTechnical && (val == null || val.isEmpty)) {
                    return 'Please assign Technical responsible';
                  }
                  if (isTechnical && (!widget.technicalMembers.contains(val))) {
                    return 'Function Responsible not found';
                  }
                  return null;
                },
              ),
            ),
          ],
        )),
        InputContainer(
            child: Column(
          children: [
            InputFrame(
              title: 'Team',
              inputField: CustomDropDown(
                dropItems: Team.values.map((e) {
                  return getTeamString(e);
                }).toList(),
                labelText: '',
                defaultValue: getTeamString(task.team),
                onSaved: (value) => task.team = getTeam(value![0])!,
                validator: (val) {
                  if (val == null) {
                    return 'Please assign team';
                  }
                  return null;
                },
              ),
            ),
            InputFrame(
              title: 'Requirements given',
              inputField: Checkbox(
                value: isRequirementGiven,
                onChanged: (value) =>
                    setState(() => isRequirementGiven = value!),
              ),
            ),
            InputFrame(
                title: 'Work type',
                inputField: CustomDropDown(
                  defaultValue: widget.workTypes.isNotEmpty &&
                          widget.workTypes.contains(task.workType)
                      ? task.workType
                      : widget.workTypes[0],
                  dropItems: widget.workTypes,
                  isEnable: true,
                  onSaved: (value) => task.workType = value!,
                  labelText: '',
                  validator: (val) {
                    if (val == null || !widget.workTypes.contains(val)) {
                      return 'Please assign work type';
                    }
                    return null;
                  },
                )),
          ],
        )),
        InputContainer(
            child: Column(children: [
          widget.formType == 'New'
              ? InputFrame(
                  title: 'Multiple task',
                  inputField: Checkbox(
                    value: multipleTask,
                    onChanged: (value) => setState(() => multipleTask = value!),
                  ),
                )
              : const SizedBox(),
          InputFrame(
            title: multipleTask ? 'Tasks' : 'Task',
            remark: multipleTask
                ? 'Add full stop after every task to separate them from each other.'
                : '',
            inputField: NormalTextField(
              defaultValue: taskDescription.isNotEmpty ? taskDescription : null,
              labelText: 'Description',
              onSaved: (value) => setState(() => taskDescription = value!),
              keyboardType:
                  multipleTask ? TextInputType.multiline : TextInputType.text,
              maxLines: multipleTask ? 5 : 1,
              verticalPadding: multipleTask ? 12 : 6,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task Description is required';
                }
                if (value.length < 5) {
                  return 'Task Description is very short';
                }
                return null;
              },
            ),
          )
        ])),
        InputContainer(
            child: Column(
          children: [
            InputFrame(
              title: 'Planning month',
              inputField: CustomDropDown(
                dropItems: months,
                defaultValue: months[task.planningMonth - 1],
                labelText: 'Choose planning month',
                onSaved: (value) {
                  task.planningMonth = months.indexOf(value!) + 1;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please provide planning month';
                  }
                  if (!months.contains(val)) {
                    return 'Planning month is not assign properly';
                  }
                  return null;
                },
              ),
            ),
            InputFrame(
                title: 'Planning week',
                inputField: CustomDropDown(
                  dropItems: weeks,
                  defaultValue: weeks[task.planningWeek - 1],
                  labelText: 'Choose planning week',
                  onSaved: (value) =>
                      task.planningWeek = weeks.indexOf(value!) + 1,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please provide planning week';
                    }
                    if (!weeks.contains(val)) {
                      return 'Planning week is not assign properly';
                    }
                    return null;
                  },
                )),
          ],
        )),
        InputContainer(
            child: Column(
          children: [
            MultipleInputFrame(
              title: 'Functional Status',
              smallerInputField: CustomDropDown(
                dropItems: statusList,
                labelText: '',
                onChange: (value) {
                  setState(() {
                    functionalStatus = getStatus(value![0])!;
                  });
                },
                onSaved: (value) {
                  task.functionalStatus = getStatus(value![0])!;
                },
                defaultValue: getStatusString(functionalStatus),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Functional status is required';
                  }
                  return null;
                },
              ),
              largerInputField: CustomDatePicker(
                defaultValue: functionalStatus == Status.close
                    ? task.functionalWorkCompleteDate != null
                        ? DateFormat(Constants.dateFormat)
                            .parse(task.functionalWorkCompleteDate!)
                        : DateTime.now()
                    : null,
                onSaved: (value) => task.functionalWorkCompleteDate =
                    functionalStatus == Status.close
                        ? DateFormat(Constants.dateFormat)
                            .format(value ?? DateTime.now())
                        : null,
                labelText: 'Complete Date',
                isEnable: functionalStatus == Status.close,
              ),
            ),
            MultipleInputFrame(
              title: 'Technical Status',
              remark: 'Dates can only be selected after making status close.',
              smallerInputField: CustomDropDown(
                dropItems: statusList,
                isEnable: isTechnical,
                labelText: '',
                onChange: (value) {
                  setState(() {
                    technicalStatus = getStatus(value![0])!;
                  });
                },
                onSaved: (value) {
                  task.technicalStatus = getStatus(value![0])!;
                },
                defaultValue: isTechnical && technicalStatus != null
                    ? getStatusString(technicalStatus!)
                    : null,
                validator: (val) {
                  if (isTechnical && (val == null || val.isEmpty)) {
                    return 'Technical status is required';
                  }
                  return null;
                },
              ),
              largerInputField: CustomDatePicker(
                defaultValue: isTechnical && technicalStatus == Status.close
                    ? task.technicalWorkCompleteDate != null
                        ? DateFormat(Constants.dateFormat)
                            .parse(task.technicalWorkCompleteDate!)
                        : DateTime.now()
                    : null,
                onSaved: (value) => task.technicalWorkCompleteDate =
                    isTechnical && technicalStatus == Status.close
                        ? DateFormat(Constants.dateFormat)
                            .format(value ?? DateTime.now())
                        : null,
                labelText: 'Complete Date',
                isEnable: technicalStatus == Status.close && isTechnical,
              ),
            )
          ],
        )),
        InputContainer(
            child: Column(
          children: [
            InputFrame(
                title: 'Functional remark',
                inputField: NormalTextField(
                  defaultValue: task.functionalRemark != null &&
                          task.functionalRemark!.isNotEmpty
                      ? task.functionalRemark
                      : null,
                  labelText: '',
                  onSaved: (value) => task.functionalRemark = value,
                  maxLines: 5,
                  verticalPadding: 12,
                  keyboardType: TextInputType.multiline,
                )),
            InputFrame(
                title: 'Technical remark',
                inputField: NormalTextField(
                  defaultValue: isTechnical &&
                          task.technicalRemark != null &&
                          task.technicalRemark!.isNotEmpty
                      ? task.technicalRemark
                      : null,
                  verticalPadding: 12,
                  labelText: '',
                  onSaved: (value) =>
                      task.technicalRemark = isTechnical ? value : null,
                  isEnable: isTechnical,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                )),
          ],
        )),
        InputContainer(
          child: InputFrame(
            title: 'Complete Date',
            remark:
                "Only be assign after ${isTechnical ? "technical and " : ""}functional work completed.",
            inputField: CustomDatePicker(
              defaultValue: functionalStatus == Status.close &&
                      (!isTechnical || technicalStatus == Status.close)
                  ? task.completeDate != null && task.completeDate!.isNotEmpty
                      ? DateFormat(Constants.dateFormat)
                          .parse(task.completeDate!)
                      : DateTime.now()
                  : null,
              isEnable: functionalStatus == Status.close &&
                  (!isTechnical || technicalStatus == Status.close),
              onSaved: (val) {
                if (functionalStatus == Status.close &&
                    (!isTechnical || technicalStatus == Status.close)) {
                  task.completeDate = DateFormat(Constants.dateFormat)
                      .format(val ?? DateTime.now());
                }
              },
              validator: (val) {
                if ((functionalStatus == Status.close &&
                    (!isTechnical || technicalStatus == Status.close) &&
                    val == null )) {
                  return 'Please assign complete date';
                }
                return null;
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PrimaryButton(
            title:
                "${widget.formType == 'New' ? 'Add' : 'Update'} ${multipleTask ? 'Tasks' : 'Task'}",
            onTap: () {
              if (widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                task.isTechnical = isTechnical;
                task.requirementGiven = isRequirementGiven;
                if (multipleTask) {
                  taskDescription.split(',').forEach((element) {
                    var newTask = task;
                    newTask.description = element;
                    print(newTask);
                  });
                } else {
                  task.description = taskDescription;
                  print(task);
                }
                widget.addTask(task);
              }
            },
            fontSize: 20,
            paddingVertical: 18,
          ),
        )
      ],
    );
  }
}
