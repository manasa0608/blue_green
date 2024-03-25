// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:postgres/postgres.dart';

import '../models/component.dart';
import '../models/personal_details.dart';
import '../user_code/user.dart';
import '../utils/constants.dart';

class Database {
  static getConnection() {
    return Connection.open(
      Endpoint(
        host: host,
        database: database,
        username: username,
        password: password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }




}
