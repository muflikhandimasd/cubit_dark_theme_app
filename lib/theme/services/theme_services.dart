import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:cubit_dark_theme_app/theme/theme_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class ThemeDBService {
  static final ThemeDBService _instance = ThemeDBService._();
  ThemeDBService._();

  factory ThemeDBService() => _instance;

  static late Box themeBox;

  static Future<void> checkDBExists() async {
    Directory themeDBDir = await getApplicationDocumentsDirectory();

    Hive.init(themeDBDir.path);

    if (await Hive.boxExists('themeBox')) {
      themeBox = await Hive.openBox('themeBox');
    } else {
      await createDatabase();
    }
  }

  static Future<void> createDatabase() async {
    Directory themeDBDir = await getApplicationDocumentsDirectory();

    Hive.init(themeDBDir.path);

    Hive.registerAdapter(ThemeDBAdapter());

    themeBox = await Hive.openBox('themeBox');

    await themeBox.put('themeSettings', true);
  }

  static putThemeSettings(bool? themeFlag) {
    themeBox.put('themeSettings', themeFlag);
  }

  static bool getThemeSettings() {
    bool themeValue = themeBox.get('themeSettings') ?? true;

    return themeValue;
  }
}
