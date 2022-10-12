import 'package:hive/hive.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 0)
class ThemeDB {
  @HiveField(0)
  bool themeSettings;
  ThemeDB({required this.themeSettings});
}
