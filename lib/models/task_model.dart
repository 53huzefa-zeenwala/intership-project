import 'package:main_project/utils/status.dart';
import 'package:main_project/utils/teams.dart';

class Task {
  String id;
  String workType;
  String description;
  String assignBy;
  Team team;
  String createdAt;
  bool isTechnical;
  bool requirementGiven;
  int planningMonth;
  int planningWeek;
  String? completeDate;
  String functionalResponsible;
  Status functionalStatus;
  String? functionalRemark;
  String? functionalWorkCompleteDate;
  String? technicalResponsible;
  Status? technicalStatus;
  String? technicalRemark;
  String? technicalWorkCompleteDate;

  Task(
      {
      required this.id,
        required this.workType,
      required this.description,
      required this.assignBy,
      required this.team,
      required this.createdAt,
      required this.requirementGiven,
      required this.isTechnical,
      required this.planningMonth,
      required this.planningWeek,
      this.completeDate,
      required this.functionalResponsible,
      required this.functionalStatus,
      this.functionalRemark,
      this.functionalWorkCompleteDate,
      this.technicalResponsible,
      this.technicalStatus,
      this.technicalRemark,
      this.technicalWorkCompleteDate});


  factory Task.fromJson(Map<String, dynamic> task) {
    return Task(
        id: task['id'],
        workType: task['workType'],
        description: task['description'],
        assignBy: task['assignBy'],
        team: task['team'],
        createdAt: task['createdAt'],
        requirementGiven: task['requirementGiven'],
        isTechnical: task['isTechnical'],
        planningMonth: task['planningMonth'],
        planningWeek: task['planningWeek'],
        completeDate: task['completeDate'],
        functionalResponsible: task['functionalResponsible'],
        functionalStatus: task['functionalStatus'],
        functionalRemark: task['functionalRemark'],
        functionalWorkCompleteDate: task['functionalWorkCompleteDate'],
        technicalResponsible: task['technicalResponsible'],
        technicalStatus: task['technicalStatus'],
        technicalRemark: task['technicalRemark'],
        technicalWorkCompleteDate: task['technicalWorkCompleteDate']);
  }
  @override
  String toString() {
    return '''Task workType - $workType 
    description - $description 
    assignBy - $assignBy 
    team - $team 
    createdAt - $createdAt 
    requirementGiven - $requirementGiven 
    isTechnical - $isTechnical 
    planningMonth - $planningMonth 
    planningWeek - $planningWeek 
    completeDate - $completeDate 
    functionalResponsible - $functionalResponsible 
    functionalStatus - $functionalStatus 
    functionalRemark - $functionalRemark 
    functionalWorkCompleteDate - $functionalWorkCompleteDate 
    technicalResponsible - $technicalResponsible 
    technicalStatus - $technicalStatus 
    technicalRemark - $technicalRemark 
    technicalWorkCompleteDate - $technicalWorkCompleteDate''';
  }
}