import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/enums.dart';

final appPreferencesProvider =
    StateNotifierProvider<AppPreferencesNotifier, AppPreferences>((ref) {
  return AppPreferencesNotifier();
});

class AppPreferences {
  final AppLanguage language;
  final AppTheme theme;

  AppPreferences({required this.language, required this.theme});
}

/// アプリの設定を管理する `StateNotifier`
/// SharedPreferencesを使って設定を永続化する
class AppPreferencesNotifier extends StateNotifier<AppPreferences> {
  AppPreferencesNotifier()
      : super(
          AppPreferences(
            language: AppLanguage.english,
            theme: AppTheme.light,
          ),
        ) {
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final languageIndex = prefs.getInt('language') ?? 0;
    final themeIndex = prefs.getInt('theme') ?? 0;

    state = AppPreferences(
      language: AppLanguage.values[languageIndex],
      theme: AppTheme.values[themeIndex],
    );
  }

  void setLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('language', language.index);
    state = AppPreferences(language: language, theme: state.theme);
  }

  void setTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', theme.index);
    state = AppPreferences(language: state.language, theme: theme);
  }
}
