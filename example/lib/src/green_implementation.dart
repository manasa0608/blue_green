
import 'green_service.dart';

class GreenServiceImpl implements GreenServiceInterface {
  @override
  Future<String> greenOperation() async {

    return 'Green service result';
  }
}