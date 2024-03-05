// ignore_for_file: depend_on_referenced_packages

import 'package:annotations/annotation.dart';

import '../models/employees.dart';
import '../models/personal_details.dart';
import '../models/treeNode.dart';

@Green
class OrganizationBuilder {
  TreeNode<Employee>? ceoNode;

  void buildOrganizationTree() {
    PersonalDetails personalDetailsOfCeo =
        PersonalDetails('Alice Johnson', 'alice.johnson@example.com');
    Employee employeeCeo =
        Employee([1, 2, 3, 4], 1, true, "CEO", 8, [2], 1, personalDetailsOfCeo);

    PersonalDetails personalDetailsOfCto =
        PersonalDetails('Bob Smith', 'bob.smith@example.com');
    Employee employeeCto = Employee(
        [1, 2, 3, 4], 2, true, "CTO", 7, [3, 4], 1, personalDetailsOfCto);

//directors
    PersonalDetails personalDetailsOfDirector1 =
        PersonalDetails('Catherine Brown', 'catherine.brown@example.com');
    Employee employeeDirector1 = Employee(
        [1, 2], 3, true, "DIRECTOR", 6, [5, 6], 2, personalDetailsOfDirector1);

    PersonalDetails personalDetailsOfDirector2 =
        PersonalDetails('David Miller', 'david.miller@example.com');
    Employee employeeDirector2 = Employee(
        [3, 4], 4, true, "DIRECTOR", 6, [7, 8], 2, personalDetailsOfDirector2);

//managers
    PersonalDetails personalDetailsOfManager1 =
        PersonalDetails('Emily Davis', 'emily.davis@example.com');
    Employee employeeManager1 = Employee([1], 5, true, "MANAGER", 5,
        [9, 10, 17, 18, 19, 20, 21], 3, personalDetailsOfManager1);

    PersonalDetails personalDetailsOfManager2 =
        PersonalDetails('Frank Wilson', 'frank.wilson@example.com');
    Employee employeeManager2 = Employee([2], 6, true, "MANAGER", 5,
        [11, 12, 22, 23, 24, 25, 26], 3, personalDetailsOfManager2);

    PersonalDetails personalDetailsOfManager3 =
        PersonalDetails('Grace Moore', 'grace.moore@example.com');
    Employee employeeManager3 = Employee([3], 7, true, "MANAGER", 5,
        [13, 14, 27, 28, 29, 30, 31], 4, personalDetailsOfManager3);

    PersonalDetails personalDetailsOfManager4 =
        PersonalDetails('Henry Lee', 'henry.lee@example.com');
    Employee employeeManager4 = Employee([4], 8, true, "MANAGER", 5,
        [15, 16, 32, 33, 34, 35, 36], 4, personalDetailsOfManager4);

//senior engineers
    List<PersonalDetails> personalDetailsOfSeniorEngineers = [
      PersonalDetails('Isabel Taylor', 'isabel.taylor@example.com'),
      PersonalDetails('James Harris', 'james.harris@example.com'),
      PersonalDetails('Katherine Clark', 'katherine.clark@example.com'),
      PersonalDetails('Louis Baker', 'louis.baker@example.com'),
      PersonalDetails('Mia Turner', 'mia.turner@example.com'),
      PersonalDetails('Nathan Allen', 'nathan.allen@example.com'),
      PersonalDetails('Olivia Martin', 'olivia.martin@example.com'),
      PersonalDetails('Peter White', 'peter.white@example.com'),
    ];

    List<Employee> seniorEngineers = [
      Employee([1], 9, false, "SENIOR_ENGINEER", 4, [], 5,
          personalDetailsOfSeniorEngineers[0]),
      Employee([1], 10, false, "SENIOR_ENGINEER", 4, [], 5,
          personalDetailsOfSeniorEngineers[1]),
      Employee([2], 11, false, "SENIOR_ENGINEER", 4, [], 6,
          personalDetailsOfSeniorEngineers[2]),
      Employee([2], 12, false, "SENIOR_ENGINEER", 4, [], 6,
          personalDetailsOfSeniorEngineers[3]),
      Employee([3], 13, false, "SENIOR_ENGINEER", 4, [], 7,
          personalDetailsOfSeniorEngineers[4]),
      Employee([3], 14, false, "SENIOR_ENGINEER", 4, [], 7,
          personalDetailsOfSeniorEngineers[5]),
      Employee([4], 15, false, "SENIOR_ENGINEER", 4, [], 8,
          personalDetailsOfSeniorEngineers[6]),
      Employee([4], 16, false, "SENIOR_ENGINEER", 4, [], 8,
          personalDetailsOfSeniorEngineers[7]),
    ];

    List<PersonalDetails> personalDetailsOfEngineers = [
      PersonalDetails('Akira Tanaka', 'akira.tanaka@example.com'),
      PersonalDetails('Hana Kim', 'hana.kim@example.com'),
      PersonalDetails('Raj Patel', 'raj.patel@example.com'),
      PersonalDetails('Mei Wong', 'mei.wong@example.com'),
      PersonalDetails('Elena Petrova', 'elena.petrova@example.com'),
      PersonalDetails('Andreas Müller', 'andreas.mueller@example.com'),
      PersonalDetails('Isabella Rossi', 'isabella.rossi@example.com'),
      PersonalDetails('Mateo Fernandez', 'mateo.fernandez@example.com'),
      PersonalDetails('Linh Nguyen', 'linh.nguyen@example.com'),
      PersonalDetails('Oliver Schmidt', 'oliver.schmidt@example.com'),
      PersonalDetails('Sofia Papadopoulos', 'sofia.papadopoulos@example.com'),
      PersonalDetails('Mikhail Ivanov', 'mikhail.ivanov@example.com'),
      PersonalDetails('Aisha Khan', 'aisha.khan@example.com'),
      PersonalDetails('Jan Novak', 'jan.novak@example.com'),
      PersonalDetails('Emma Wilson', 'emma.wilson@example.com'),
      PersonalDetails('Mohammed Ali', 'mohammed.ali@example.com'),
      PersonalDetails('Anna Kowalski', 'anna.kowalski@example.com'),
      PersonalDetails('Lucas Silva', 'lucas.silva@example.com'),
      PersonalDetails('Mia Turner', 'mia.turner@example.com'),
      PersonalDetails('Matteo Russo', 'matteo.russo@example.com'),
    ];

    List<Employee> engineers = [
      Employee(
          [1], 17, false, "ENGINEER", 3, [], 5, personalDetailsOfEngineers[0]),
      Employee(
          [1], 18, false, "ENGINEER", 3, [], 5, personalDetailsOfEngineers[1]),
      Employee(
          [1], 19, false, "ENGINEER", 3, [], 5, personalDetailsOfEngineers[2]),
      Employee(
          [1], 20, false, "ENGINEER", 3, [], 5, personalDetailsOfEngineers[3]),
      Employee(
          [1], 21, false, "ENGINEER", 3, [], 5, personalDetailsOfEngineers[4]),
      Employee(
          [2], 22, false, "ENGINEER", 3, [], 6, personalDetailsOfEngineers[5]),
      Employee(
          [2], 23, false, "ENGINEER", 3, [], 6, personalDetailsOfEngineers[6]),
      Employee(
          [2], 24, false, "ENGINEER", 3, [], 6, personalDetailsOfEngineers[7]),
      Employee(
          [2], 25, false, "ENGINEER", 3, [], 6, personalDetailsOfEngineers[8]),
      Employee(
          [2], 26, false, "ENGINEER", 3, [], 6, personalDetailsOfEngineers[9]),
      Employee(
          [3], 27, false, "ENGINEER", 3, [], 7, personalDetailsOfEngineers[10]),
      Employee(
          [3], 28, false, "ENGINEER", 3, [], 7, personalDetailsOfEngineers[11]),
      Employee(
          [3], 29, false, "ENGINEER", 3, [], 7, personalDetailsOfEngineers[12]),
      Employee(
          [3], 30, false, "ENGINEER", 3, [], 7, personalDetailsOfEngineers[13]),
      Employee(
          [3], 31, false, "ENGINEER", 3, [], 7, personalDetailsOfEngineers[14]),
      Employee(
          [4], 32, false, "ENGINEER", 3, [], 8, personalDetailsOfEngineers[15]),
      Employee(
          [4], 33, false, "ENGINEER", 3, [], 8, personalDetailsOfEngineers[16]),
      Employee(
          [4], 34, false, "ENGINEER", 3, [], 8, personalDetailsOfEngineers[17]),
      Employee(
          [4], 35, false, "ENGINEER", 3, [], 8, personalDetailsOfEngineers[18]),
      Employee(
          [4], 36, false, "ENGINEER", 3, [], 8, personalDetailsOfEngineers[19])
    ];

    // Team team1 = Team(1, 11, [
    //   employeeCeo,
    //   employeeCto,
    //   employeeDirector1,
    //   employeeManager1,
    //   seniorEngineers[0],
    //   seniorEngineers[1],
    //   engineers[0],
    //   engineers[1],
    //   engineers[2],
    //   engineers[3],
    //   engineers[4],
    // ]);

    // Team team2 = Team(2, 11, [
    //   employeeCeo,
    //   employeeCto,
    //   employeeDirector1,
    //   employeeManager1,
    //   seniorEngineers[2],
    //   seniorEngineers[3],
    //   engineers[5],
    //   engineers[6],
    //   engineers[7],
    //   engineers[8],
    //   engineers[9],
    // ]);

    // Team team3 = Team(3, 11, [
    //   employeeCeo,
    //   employeeCto,
    //   employeeDirector2,
    //   employeeManager2,
    //   seniorEngineers[4],
    //   seniorEngineers[5],
    //   engineers[10],
    //   engineers[11],
    //   engineers[12],
    //   engineers[13],
    //   engineers[14],
    // ]);

    // Team team4 = Team(4, 11, [
    //   employeeCeo,
    //   employeeCto,
    //   employeeDirector2,
    //   employeeManager2,
    //   seniorEngineers[6],
    //   seniorEngineers[7],
    //   engineers[15],
    //   engineers[16],
    //   engineers[17],
    //   engineers[18],
    //   engineers[19],
    // ]);

    ceoNode = TreeNode<Employee>(employeeCeo);
    TreeNode<Employee> ctoNode = TreeNode<Employee>(employeeCto);

    TreeNode<Employee> directorNode1 = TreeNode<Employee>(employeeDirector1);
    TreeNode<Employee> directorNode2 = TreeNode<Employee>(employeeDirector2);

    TreeNode<Employee> managerNode1 = TreeNode<Employee>(employeeManager1);
    TreeNode<Employee> managerNode2 = TreeNode<Employee>(employeeManager2);
    TreeNode<Employee> managerNode3 = TreeNode<Employee>(employeeManager3);
    TreeNode<Employee> managerNode4 = TreeNode<Employee>(employeeManager4);

    List<TreeNode<Employee>> seniorEngineerNodes =
        seniorEngineers.map((seniorEngineer) {
      return TreeNode<Employee>(seniorEngineer);
    }).toList();

    // Create tree nodes for Engineers
    List<TreeNode<Employee>> engineerNodes = engineers.map((engineer) {
      return TreeNode<Employee>(engineer);
    }).toList();

    ceoNode?.addChild(ctoNode);

    ctoNode.addChild(directorNode1);
    ctoNode.addChild(directorNode2);

    directorNode1.addChild(managerNode1);
    directorNode1.addChild(managerNode2);

    directorNode2.addChild(managerNode3);
    directorNode2.addChild(managerNode4);

    managerNode1.addChild(seniorEngineerNodes[0]);
    managerNode1.addChild(seniorEngineerNodes[1]);
    managerNode1.addChild(engineerNodes[0]);
    managerNode1.addChild(engineerNodes[1]);
    managerNode1.addChild(engineerNodes[2]);
    managerNode1.addChild(engineerNodes[3]);
    managerNode1.addChild(engineerNodes[4]);

    managerNode2.addChild(seniorEngineerNodes[2]);
    managerNode2.addChild(seniorEngineerNodes[3]);
    managerNode2.addChild(engineerNodes[5]);
    managerNode2.addChild(engineerNodes[6]);
    managerNode2.addChild(engineerNodes[7]);
    managerNode2.addChild(engineerNodes[8]);
    managerNode2.addChild(engineerNodes[9]);

// For managerNode3
    managerNode3.addChild(seniorEngineerNodes[4]);
    managerNode3.addChild(seniorEngineerNodes[5]);
    managerNode3.addChild(engineerNodes[10]);
    managerNode3.addChild(engineerNodes[11]);
    managerNode3.addChild(engineerNodes[12]);
    managerNode3.addChild(engineerNodes[13]);
    managerNode3.addChild(engineerNodes[14]);

// For managerNode4
    managerNode4.addChild(seniorEngineerNodes[6]);
    managerNode4.addChild(seniorEngineerNodes[7]);
    managerNode4.addChild(engineerNodes[15]);
    managerNode4.addChild(engineerNodes[16]);
    managerNode4.addChild(engineerNodes[17]);
    managerNode4.addChild(engineerNodes[18]);
    managerNode4.addChild(engineerNodes[19]);
  }

  TreeNode<Employee>? getRootNode() {
    buildOrganizationTree();
    return ceoNode;
  }
}
