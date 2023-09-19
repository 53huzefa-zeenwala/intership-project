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
  @override
  String toString() {
    return 'Member firstName: $firstName lastName: $lastName phoneNumber: $phoneNumber department: $department team: $team joinDate: $joinDate email: $email id: $id assignTasks: $assignTasks pendingTasks: $pendingTasks completedTasks: $completedTasks';
  }
}
