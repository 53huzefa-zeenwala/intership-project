import 'package:main_project/utils/departments.dart';
import 'package:main_project/utils/teams.dart';

class Member {
  String id;
  String firstName;
  String lastName;
  String? phoneNumber;
  Department department;
  Team team;
  String? joinDate;
  String email;
  int assignTasks;
  int pendingTasks;
  int completedTasks;

  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.department,
    required this.email,
    this.joinDate,
    required this.team,
    this.assignTasks = 0,
    this.completedTasks = 0,
    this.pendingTasks = 0,
  });

  factory Member.fromJson(Map<String, dynamic> data) {
    return Member(
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      department: data['department'],
      team: data['team'],
      joinDate: data['joinDate'],
      email: data['email'],
      id: data['id'],
      assignTasks: data['assignTasks'],
      pendingTasks: data['pendingTasks'],
      completedTasks: data['completedTasks'],
    );
  }
  factory Member.fromStringData(List data, List header) {
    var department = getDepartment(data[header.indexOf('department')][0]);
    var team = getTeam(data[header.indexOf('team')][0]);
    if (team == null || department == null) {
      throw Exception('Data Format is not correct, try changing file.');
    }
    int getTaskCount(title) {
      if (!header.contains(title) || data[header.indexOf(title)] == null) {
        return 0;
      } else {
        var taskCount = int.tryParse(data[header.indexOf(title)]);
        if (taskCount == null) {
          throw Exception('Value is not assign correctly for $title');
        }
        return taskCount;
      }
    }

    return Member(
      id: data[header.indexOf('id')],
      firstName: data[header.indexOf('firstName')],
      lastName: data[header.indexOf('lastName')],
      department: department,
      email: data[header.indexOf('email')],
      team: team,
      assignTasks: getTaskCount('assignTasks'),
      pendingTasks: getTaskCount('pendingTasks'),
      completedTasks: getTaskCount('completedTasks'),
      joinDate:
          header.contains('joinDate') ? data[header.indexOf('joinDate')] : null,
      phoneNumber: header.contains('phoneNumber')
          ? data[header.indexOf('phoneNumber')]
          : null,
    );
  }
  @override
  String toString() {
    return 'Member firstName: $firstName lastName: $lastName phoneNumber: $phoneNumber department: $department team: $team joinDate: $joinDate email: $email id: $id assignTasks: $assignTasks pendingTasks: $pendingTasks completedTasks: $completedTasks';
  }
}
