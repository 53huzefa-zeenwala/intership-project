import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Status { open, pending, close }

String getStatusValue(Status data) {
  return describeEnum(data)[0].toUpperCase();
}

Status? getStatus(String val) {
  for (final e in Status.values) {
    if (describeEnum(e)[0].toUpperCase() == val.toUpperCase()) {
      return e;
    }
  }
  return null;
}

String getStatusString(Status data) {
  final val = describeEnum(data);
  return val[0].toUpperCase() + val.substring(1);
}

Color getStatusColor(Status data) {
  switch (data) {
    case Status.open:
      return const Color.fromARGB(255, 255, 123, 162);
    case Status.pending:
      return const Color.fromARGB(255, 255, 194, 60);
    default:
      return const Color.fromARGB(255, 21, 181, 105);
  }
}
