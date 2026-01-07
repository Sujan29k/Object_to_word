import 'dart:convert';
import 'package:flutter/services.dart';
import '../../models/level_model.dart';

class LevelLoader {
  static Future<List<Level>> loadLevels() async {
    final data = await rootBundle.loadString('assets/data/levels.json');
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((e) => Level.fromJson(e)).toList();
  }
}
