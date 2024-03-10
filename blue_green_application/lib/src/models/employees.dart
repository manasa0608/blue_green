import 'package:example/src/models/personal_details.dart';

class Employee {
  late List<int> teams;
  late int id;
  late bool isManagingPeople;
  late String designation;
  late int level;
  late List<int> directReportees;
  bool exitFlag = false;
  bool updateRequired = false;
  late int managerId;
  late PersonalDetails personalDetails;

  Employee(
    this.teams,
    this.id,
    this.isManagingPeople,
    this.designation,
    this.level,
    this.directReportees,
    this.managerId,
    this.personalDetails,
  );
}
