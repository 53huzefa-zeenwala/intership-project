import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:main_project/constants/dummy_tasks.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/widgets/layouts/base_dialog.dart';
import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/layouts/filter_dialog.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';
import 'package:go_router/go_router.dart';
import 'package:main_project/utils/departments.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  List<String> sortFrom = [
    'Join Date',
    'Task Assign',
    'Task Pending',
    'Task Completed'
  ];
  late String sortTo;
  String sortBy = 'Inc';
  String filterDepartment = 'All';
  String filterTeam = 'All';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortTo = sortFrom[0];
  }

  @override
  Widget build(BuildContext context) {
    final departments = Department.values.map((e) => describeEnum(e)).toList();
    departments.add('All');
    return BaseLayout(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const PageHeading(title: 'Members'),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 220,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        // fillColor: Theme.of(context).colorScheme.onTertiary,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.merge(TextStyle(color: Colors.grey.shade500)),
                        hintText: 'Search here',
                      ).applyDefaults(Theme.of(context).inputDecorationTheme),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Row(
                    children: [
                      Row(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          height: 45,
                          width: 150,
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
                              items: sortFrom.map((val) {
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
                                  height: 300,
                                  filters: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Filter(
                                        title: 'Department',
                                        dropItems: departments,
                                        currentValue: filterDepartment,
                                        onChange: (val) => setState(
                                            () => filterDepartment = val!),
                                      ),
                                      Filter(
                                          title: 'Team',
                                          dropItems: const [
                                            'All',
                                            'Implementation',
                                            'Support'
                                          ],
                                          currentValue: filterTeam,
                                          onChange: (val) =>
                                              setState(() => filterTeam = val!))
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
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Theme.of(context).primaryColorLight,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dataContainer(
                          context,
                          data: Text(
                            'Name',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          flex: 1,
                        ),
                        dataContainer(
                          context,
                          data: Text(
                            'Contact',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          flex: 2,
                        ),
                        dataContainer(
                          context,
                          data: Text(
                            'Team',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        dataContainer(
                          context,
                          data: Text(
                            'Department',
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                          ),
                        ),
                        dataContainer(
                          context,
                          data: Text(
                            'Role',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        dataContainer(
                          context,
                          data: Text(
                            'Assign',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          width: 80,
                          flex: 0,
                        ),
                        const SizedBox(width: 30)
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return Container(
                        color:
                            index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            dataContainer(
                              context,
                              data: Text(
                                '${member.firstName} ${member.lastName}',
                                style: Theme.of(context).textTheme.displaySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              flex: 1,
                            ),
                            dataContainer(
                              context,
                              data: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  member.phoneNumber != null
                                      ? Text(
                                          member.phoneNumber!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : const SizedBox(),
                                  Text(
                                    member.email,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                ],
                              ),
                              flex: 2,
                            ),
                            dataContainer(
                              context,
                              data: Text(
                                getTeamString(member.team),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            dataContainer(
                              context,
                              data: Text(
                                getDepartmentString(member.department),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            dataContainer(
                              context,
                              data: Text(
                                'Junior Developer',
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            dataContainer(
                              context,
                              data: Text(
                                member.assignTasks.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              dataAlign: Alignment.center,
                              width: 80,
                              flex: 0,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => MemberDetailDialog(
                                            data: member,
                                          ));
                                },
                                icon: const Icon(Icons.more_vert))
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   Flexible dataContainer(BuildContext context,
      {required Widget data,
      double? width,
      Alignment dataAlign = Alignment.centerLeft,
      int flex = 1}) {
    return Flexible(
      fit: width == null ? FlexFit.tight : FlexFit.loose,
      flex: flex,
      child: Container(
        padding: const EdgeInsets.only(right: 5),
        width: width,
        alignment: dataAlign,
        child: data,
      ),
    );
  }
}

class MemberDetailDialog extends StatelessWidget {
  final Member data;
  const MemberDetailDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      maxWidth: 500,
      mainFunction: () {
        context.go('/members/${data.id}');
      },
      title: '${data.firstName} ${data.lastName}',
      displayData: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: Column(
          children: [
            detail(context, title: 'Team', data: getTeamString(data.team)),
            detail(context, title: 'Department', data: getDepartmentString(data.department)),
            detail(context,
                title: 'Join Date', data: data.joinDate ?? 'Not Provided'),

            detail(context, title: 'Email', data: data.email),
            detail(context,
                title: 'Phone Number',
                data: data.phoneNumber ?? 'Not Provided'),
            detail(context, title: 'Role', data: 'Junior Developer'),
            detail(context,
                title: 'Task Assign', data: data.assignTasks.toString()),
            detail(context,
                title: 'Task Pending', data: data.pendingTasks.toString()),
            detail(context,
                title: 'Task Completed', data: data.completedTasks.toString()),
          ],
        ),
      ),
    );
  }

  Padding detail(BuildContext context,
      {required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            Text(data, style: Theme.of(context).textTheme.labelMedium)
          ]),
    );
  }
}
