import 'package:intl/intl.dart';
import 'package:main_project/models/member_model.dart';
import 'package:main_project/models/task_model.dart';
import 'package:main_project/utils/constants.dart';
import 'package:main_project/utils/departments.dart';
import 'package:main_project/utils/teams.dart';
import 'package:main_project/utils/status.dart';

List<Member> members = [
  Member(
    id: '1',
    firstName: 'Jayash',
    lastName: 'Pragya',
    department: Department.functional,
    email: 'Jayash@example.com',
    team: Team.implementation,
  ),
  Member(
    id: '2',
    firstName: 'Jitendra',
    lastName: 'Sharma',
    department: Department.account,
    email: 'Jitendra329@example.com',
    team: Team.implementation,
    phoneNumber: '463973489723',
  ),
  Member(
    id: '3',
    firstName: 'Randomlarge',
    lastName: 'Namelast',
    department: Department.account,
    email: 'Randomlarge.Namelast@example.com',
    team: Team.implementation,
    phoneNumber: '463973489723',
  )
];

final List<Task> tasks = [
  Task(
    id: '1',
    workType: 'FMS',
    description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti praesentium accusamus corporis molestiae? Sunt similique, harum, culpa hic numquam, corporis atque obcaecati.',
    createdAt: DateFormat(Constants.dateFormat).format(DateTime.now()),
    team: Team.implementation,
    isTechnical: true,
    requirementGiven: false,
    assignBy: 'Ansissss',
    planningMonth: 9,
    planningWeek: 1,
    functionalResponsible: 'Anssss',
    functionalWorkCompleteDate:
        DateFormat(Constants.dateFormat).format(DateTime.now()),
    functionalStatus: Status.close,
    functionalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    technicalResponsible: 'Finalll',
    technicalStatus: Status.pending,
    technicalWorkCompleteDate: null,
    technicalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    completeDate: null,
  ),
  Task(
    id: '2',
    workType: 'FMS',
    description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti praesentium accusamus corporis molestiae? Sunt similique, harum, culpa hic numquam, corporis atque obcaecati.',
    createdAt: DateFormat(Constants.dateFormat).format(DateTime.now()),
    team: Team.implementation,
    isTechnical: true,
    requirementGiven: false,
    assignBy: 'Ansissss',
    planningMonth: 9,
    planningWeek: 1,
    functionalResponsible: 'Anssss',
    functionalWorkCompleteDate:
        DateFormat(Constants.dateFormat).format(DateTime.now()),
    functionalStatus: Status.close,
    functionalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    technicalResponsible: 'Finalll',
    technicalStatus: Status.close,
    technicalWorkCompleteDate:
        DateFormat(Constants.dateFormat).format(DateTime.now()),
    technicalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    completeDate: DateFormat(Constants.dateFormat).format(DateTime.now()),
  ),
  Task(
    id: '3',
    workType: 'Attribute',
    description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti praesentium accusamus corporis molestiae? Sunt similique, harum, culpa hic numquam, corporis atque obcaecati.',
    createdAt: DateFormat(Constants.dateFormat).format(DateTime.now()),
    team: Team.implementation,
    isTechnical: false,
    requirementGiven: false,
    assignBy: 'Ansissss',
    planningMonth: 9,
    planningWeek: 1,
    functionalResponsible: 'Anssss',
    functionalWorkCompleteDate: null,
    functionalStatus: Status.open,
    functionalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    technicalResponsible: null,
    technicalStatus: null,
    technicalWorkCompleteDate: null,
    technicalRemark: null,
    completeDate: null,
  ),
  Task(
    id: '4',
    workType: 'Attribute',
    description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti praesentium accusamus corporis molestiae? Sunt similique, harum, culpa hic numquam, corporis atque obcaecati.',
    createdAt: DateFormat(Constants.dateFormat).format(DateTime.now()),
    team: Team.implementation,
    isTechnical: false,
    requirementGiven: false,
    assignBy: 'Ansissss',
    planningMonth: 10,
    planningWeek: 1,
    functionalResponsible: 'Anssss',
    functionalWorkCompleteDate: null,
    functionalStatus: Status.open,
    functionalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    technicalResponsible: null,
    technicalStatus: null,
    technicalWorkCompleteDate: null,
    technicalRemark: null,
    completeDate: null,
  ),
  Task(
    id: '5',
    workType: 'FMS',
    description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti praesentium accusamus corporis molestiae? Sunt similique, harum, culpa hic numquam, corporis atque obcaecati.',
    createdAt: DateFormat(Constants.dateFormat).format(DateTime.now()),
    team: Team.implementation,
    isTechnical: false,
    requirementGiven: false,
    assignBy: 'Ansissss',
    planningMonth: 9,
    planningWeek: 1,
    functionalResponsible: 'Anssss',
    functionalWorkCompleteDate: null,
    functionalStatus: Status.pending,
    functionalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    technicalResponsible: null,
    technicalStatus: null,
    technicalWorkCompleteDate: null,
    technicalRemark: null,
    completeDate: null,
  ),
  Task(
    id: '6',
    workType: 'Attribute',
    description:
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Deleniti praesentium accusamus corporis molestiae? Sunt similique, harum, culpa hic numquam, corporis atque obcaecati.',
    createdAt: DateFormat(Constants.dateFormat).format(DateTime.now()),
    team: Team.implementation,
    isTechnical: false,
    requirementGiven: false,
    assignBy: 'Ansissss',
    planningMonth: 9,
    planningWeek: 1,
    functionalResponsible: 'Anssss',
    functionalWorkCompleteDate: null,
    functionalStatus: Status.close,
    functionalRemark:
        'ducimus nostrum rem assumenda modi tempora delectus magnam! Recusandae quaerat aut ut iste animi sequi corporis.',
    technicalResponsible: null,
    technicalStatus: null,
    technicalWorkCompleteDate: null,
    technicalRemark: null,
    completeDate: DateFormat(Constants.dateFormat).format(DateTime.now()),
  ),
  Task(
    id: '742250b3-5357-452c-9b54-d72c0f879f97',
    workType: 'Check',
    description: 'BtgkTUmoLAsgFj xZBfXEh HSNf, Agathe',
    assignBy: 'Agathe',
    team: Team.implementation,
    createdAt: '2020-01-05',
    requirementGiven: true,
    isTechnical: false,
    planningMonth: 6,
    planningWeek: 4,
    functionalResponsible: 'Eadie',
    functionalStatus: Status.pending,
  ),
  Task(
    id: 'bd9a3585-abbf-4f15-a9f1-da7af1b7a910',
    workType: 'Check',
    description: 'BtgkTUmoLAsgFj xZBfXEh HSNf, Agathe',
    assignBy: 'Rivalee',
    team: Team.implementation,
    createdAt: '2020-12-13',
    requirementGiven: true,
    isTechnical: false,
    planningMonth: 6,
    planningWeek: 1,
    functionalResponsible: 'Kathy',
    functionalStatus: Status.close,
    functionalWorkCompleteDate: '2023-09-21',
    completeDate: '2023-09-21',
  ),
];

/* 
[742250b3-5357-452c-9b54-d72c0f879f97, implementation, Check, BtgkTUmoLAsgFj xZBfXEh HSNf, Agathe, 2020-01-05, Yes, false, 6, 4, Eadie, Pending, , ], [bd9a3585-abbf-4f15-a9f1-da7af1b7a910, support, Check, hwwIXiFTALBPpizmtrWFXzScBCFlrSMCrtvUjAmHsLosKISALuVwtDVgCOuYBGDksdzJQQgxLslkp, Rivalee, 2020-12-13, Yes, false, 6, 1, Kathy, Close, 2023-09-21, 2023-09-21]
*/