import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder_flutter/screens/search_screen.dart';
import 'package:github_finder_flutter/providers/github_repositories_provider.dart';
import 'package:github_finder_flutter/providers/test_mode_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:github_finder_flutter/widgets/repository_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  testWidgets('SearchScreen displays search results',
      (WidgetTester tester) async {
    // Mock HTTP client
    final mockHttpClient = MockClient((request) async {
      final response = {
        'items': [
          {
            'id': 1,
            'name': 'flutter',
            'full_name': 'flutter/flutter',
            'owner': {
              'login': 'flutter',
              'avatar_url':
                  'https://avatars.githubusercontent.com/u/14101776?v=4',
            },
            'description':
                'Flutter makes it easy and fast to build beautiful apps for mobile and beyond.',
            'language': 'Dart',
            'stargazers_count': 123456,
            'watchers_count': 123456,
            'forks_count': 12345,
            'open_issues_count': 1234,
            'html_url': 'https://github.com/flutter/flutter',
          },
        ],
      };
      return http.Response(json.encode(response), 200);
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          githubRepositoriesProvider.overrideWith(
            (ref) => GitHubRepositoriesNotifier(httpClient: mockHttpClient),
          ),
          testModeProvider.overrideWithValue(true),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: SearchScreen(),
          locale: Locale('en'),
        ),
      ),
    );

    // 検索欄が表示されていることを確認
    expect(find.byType(TextField), findsOneWidget);

    // 検索キーワードを入力して検索ボタンをタップ
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // 検索結果が表示されていることを確認
    expect(find.byType(RepositoryListItem), findsOneWidget);
    expect(find.text('Stars: 123456'), findsOneWidget);
  });
}
