
import 'package:blue_green_application/src/models/personal_details.dart';

class Component {
  int id;
  int level;
  PersonalDetails personalDetails;
  List<int> listOfHigherComponentsId; //3>2>1 - higher value indicates higher level
  List<int> listOfLowerComponentsId;
  double amountAccountable;

  //one child can belong to 2 parents
  Component(this.id, this.level, this.personalDetails, this.listOfHigherComponentsId, this.listOfLowerComponentsId, this.amountAccountable);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'personalDetails': personalDetails.toJson(),
      'listOfHigherComponentsId': listOfHigherComponentsId,
      'listOfLowerComponentsId': listOfLowerComponentsId,
      'amountAccountable': amountAccountable,
    };
  }

  static Component fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int level = json['level'];
    PersonalDetails personalDetails = PersonalDetails.fromJson(json['personalDetails']);
    List<int> listOfHigherComponentsId = List<int>.from(json['listOfHigherComponentsId']);
    List<int> listOfLowerComponentsId = List<int>.from(json['listOfLowerComponentsId']);
    double amountAccountable = json['amountAccountable'];

    return Component(id, level, personalDetails, listOfHigherComponentsId, listOfLowerComponentsId, amountAccountable);
  }
}
