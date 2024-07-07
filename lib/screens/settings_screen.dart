import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/enums.dart';
import '../providers/preferences_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appPreferences = ref.watch(appPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio<AppLanguage>(
                value: AppLanguage.english,
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
            ListTile(
              title: const Text('Japanese'),
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
            const Text(
              'Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Light'),
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
              title: const Text('Dark'),
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
