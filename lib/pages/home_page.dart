import 'package:flutter/material.dart';
import 'package:main_project/constants/dummy_tasks.dart';
import 'package:main_project/models/member_model.dart';
// import 'package:main_project/widgets/custom_fields/custom_dropdown.dart';
import 'package:main_project/widgets/layouts/base_layout.dart';
import 'package:main_project/widgets/layouts/page_heading.dart';
import 'package:main_project/widgets/home/single_task.dart';
import 'package:main_project/utils/status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Member person = members[0];

  @override
  Widget build(BuildContext context) {
    // print(DateFormat('MMMM').format(DateTime.now()));
    return BaseLayout(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            const PageHeading(title: 'Overview'),

            // * Carousal show number of task assign to user
            const Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Carousal(
                  count: 5,
                  icon: Icons.calendar_month_outlined,
                  title: 'Open Tasks',
                  iconColor: Color.fromARGB(255, 255, 123, 162),
                  backgroundColor: Color.fromARGB(255, 252, 149, 188),
                ),
                Carousal(
                  count: 5,
                  icon: Icons.pending_actions_outlined,
                  title: 'In-progress Tasks',
                  iconColor: Color.fromARGB(255, 255, 194, 60),
                  backgroundColor: Color.fromARGB(255, 255, 206, 98),
                ),
                Carousal(
                  count: 5,
                  icon: Icons.library_add_check_rounded,
                  title: 'Completed Tasks',
                  iconColor: Color.fromARGB(255, 21, 181, 105),
                  backgroundColor: Color.fromARGB(255, 11, 197, 109),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),

            // * Display task of the user
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Tasks',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Filter',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          height: 50,
                          width: 150,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                            value: Status.open,
                            items: Status.values.map((Status value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  getStatusString(value),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => {},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  // constraints: BoxConstraints(minWidth: 910),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return SingleTask(
                        taskIndex: index,
                        user: person,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Carousal extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final Color iconColor;
  final Color backgroundColor;

  const Carousal({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 120,
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints(maxWidth: 100),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: Colors.black, width: 2)
              // color: backgroundColor
              ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: iconColor),
                    child: Icon(icon, size: 20, color: Colors.black)),
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Text(count.toString(),
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 0.75)),
              ])),
    );
  }
}
