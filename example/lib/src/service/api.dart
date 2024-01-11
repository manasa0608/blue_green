// ignore_for_file: unused_element

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/system_config.dart';

class Api {
  Future<SystemConfig> getSystemDetails() async {
    const localhostUrl = 'http://localhost:8080'; // Update with your server URL
    final url = Uri.parse('$localhostUrl/get-system-config');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        final system = json['system'] as String;
        final isRunning = json['isRunning'] as bool;

        return SystemConfig(system, isRunning);
      } else {
        throw Exception('Failed to load system config');
      }
    } catch (e) {
      throw Exception('Failed to load system config');
    }
  }
}
