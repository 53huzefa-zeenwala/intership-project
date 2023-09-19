import 'package:flutter/foundation.dart';

enum Department { technical, functional, account, hr }

String getDepartmentValue(Department data) {
  return describeEnum(data)[0].toUpperCase();
}

Department? getDepartment(String val) {
  for (final e in Department.values) {
    if (describeEnum(e)[0].toUpperCase() == val) {
      return e;
    }
  }
  return null;
}

String getDepartmentString(Department data) {
  final val = describeEnum(data);
  return val[0].toUpperCase() + val.substring(1);
}
