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
      {required this.id,
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
  factory Task.fromCSV(List data, List header) {
    var team = getTeam(data[header.indexOf('team')][0]);
    if (team == null) {
      throw Exception('Data Format is not correct, try changing file.');
    }
    Status getTaskStatus(String title) {
      if (!header.contains(title) || data[header.indexOf(title)] == null) {
        return Status.open;
      } else {
        var status = getStatus(data[header.indexOf(title)][0]);
        if (status == null) {
          throw Exception('Status of $title is not defined properly');
        }
        return status;
      }
    }

    bool getBool(String data) {
      data = data.toLowerCase();
      if (data == 'true' || data == 'yes') {
        return true;
      } else {
        return false;
      }
    }

    int convertStringToInt(String data) {
      int? returnData = int.tryParse(data);
      if (returnData == null) {
        throw Exception('Exception int data but got $data');
      }
      return returnData;
    }

    return Task(
      id: data[header.indexOf('id')],
      workType: data[header.indexOf('workType')],
      description: data[header.indexOf('description')],
      assignBy: data[header.indexOf('assignBy')],
      team: team,
      createdAt: data[header.indexOf('createdAt')],
      requirementGiven: getBool(data[header.indexOf('requirementGiven')]),
      isTechnical: getBool(data[header.indexOf('isTechnical')]),
      planningMonth: convertStringToInt(data[header.indexOf('planningMonth')]),
      planningWeek: convertStringToInt(data[header.indexOf('planningWeek')]),
      functionalResponsible: data[header.indexOf('functionalResponsible')],
      functionalStatus: getTaskStatus('functionalStatus'),
      completeDate: header.contains('completeDate')
          ? data[header.indexOf('completeDate')]
          : null,
      functionalRemark: header.contains('functionalRemark')
          ? data[header.indexOf('functionalRemark')]
          : null,
      functionalWorkCompleteDate: header.contains('functionalWorkCompleteDate')
          ? data[header.indexOf('functionalWorkCompleteDate')]
          : null,
      technicalRemark: header.contains('technicalRemark')
          ? data[header.indexOf('technicalRemark')]
          : null,
      technicalResponsible: header.contains('technicalResponsible')
          ? data[header.indexOf('technicalResponsible')]
          : null,
      technicalStatus: header.contains('technicalStatus')
          ? getTaskStatus('technicalStatus')
          : null,
      technicalWorkCompleteDate: header.contains('technicalWorkCompleteDate')
          ? data[header.indexOf('technicalWorkCompleteDate')]
          : null,
    );
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
