import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ConfigLoader {
  static Future<Map<String, dynamic>> load(String env) async {
    final configString = await rootBundle.loadString('config/$env.json');
    return json.decode(configString) as Map<String, dynamic>;
  }
}
