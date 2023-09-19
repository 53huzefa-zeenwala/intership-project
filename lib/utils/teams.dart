import 'package:flutter/foundation.dart';

enum Team { support, implementation }

String getTeamValue(Team data) {
  return describeEnum(data)[0].toUpperCase();
}

Team? getTeam(String val) {
  for (final e in Team.values) {
    if (describeEnum(e)[0].toUpperCase() == val) {
      return e;
    }
  }
  return null;
}

String getTeamString(Team data) {
  final val = describeEnum(data);
  return val[0].toUpperCase() + val.substring(1);
}
