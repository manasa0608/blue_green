import 'package:blue_green_application/src/database/user_database.dart';

class UserService {
  Future<String> addUser(String username, String email) async {
    return UserDatabase.addUser(username, email);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    return UserDatabase.getAllUsers();
  }

  Future<Map<String, dynamic>> getUserById(int id) async {
    return UserDatabase.getUserDetails(id);
  }
}
