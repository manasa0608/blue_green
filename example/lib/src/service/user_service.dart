import 'package:example/src/utils/database.dart';

class UserService {
  Future<String> addUser(String username, String email) async {
    return Database.addUser(username, email);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return Database.getAllUsers();
  }

  Future<Map<String, dynamic>> getUserById(int id) async {
    return Database.getUserDetails(id);
  }
}
