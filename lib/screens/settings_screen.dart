import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/enums.dart';
import '../providers/preferences_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 設定画面
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appPreferences = ref.watch(appPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.settings_language,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.settings_language_english,
              ),
              leading: Radio<AppLanguage>(
                value: AppLanguage.english,
                groupValue: appPreferences.language,
                onChanged: (AppLanguage? value) {
                  // アプリ全体に反映される上に、その設定が本体に保存される
                  if (value != null) {
                    ref
                        .read(appPreferencesProvider.notifier)
                        .setLanguage(value);
                  }
                },
              ),
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.settings_language_japanese,
              ),
              leading: Radio<AppLanguage>(
                value: AppLanguage.japanese,
                groupValue: appPreferences.language,
                onChanged: (AppLanguage? value) {
                  if (value != null) {
                    ref
                        .read(appPreferencesProvider.notifier)
                        .setLanguage(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.settings_theme,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.settings_theme_light),
              leading: Radio<AppTheme>(
                value: AppTheme.light,
                groupValue: appPreferences.theme,
                onChanged: (AppTheme? value) {
                  if (value != null) {
                    ref.read(appPreferencesProvider.notifier).setTheme(value);
                  }
                },
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.settings_theme_dark),
              leading: Radio<AppTheme>(
                value: AppTheme.dark,
                groupValue: appPreferences.theme,
                onChanged: (AppTheme? value) {
                  if (value != null) {
                    ref.read(appPreferencesProvider.notifier).setTheme(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
