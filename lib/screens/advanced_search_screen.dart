import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/github_repositories_provider.dart';
import '../providers/search_state_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 詳細検索画面
class AdvancedSearchScreen extends ConsumerStatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  ConsumerState<AdvancedSearchScreen> createState() =>
      _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends ConsumerState<AdvancedSearchScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _formErrorMessage;

  bool _isFormValid() {
    // キーワード、ユーザー名、組織名のいずれかが入力されていることを確認
    final searchState = ref.read(searchStateProvider);
    return searchState.keyword.isNotEmpty ||
        searchState.username.isNotEmpty ||
        searchState.organization.isNotEmpty;
  }

  void _performSearch() {
    setState(() {
      _formErrorMessage = null;
    });

    if (_formKey.currentState!.validate() && _isFormValid()) {
      final searchState = ref.read(searchStateProvider);
      final query = searchState.buildSearchQuery();
      ref.read(githubRepositoriesProvider.notifier).searchRepositories(query);
      Navigator.pop(context);
    } else {
      setState(() {
        _formErrorMessage = AppLocalizations.of(context)!.advanced_search_error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.advanced_search_title),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // エラーメッセージがあれば表示
            if (_formErrorMessage != null) ...[
              Text(
                _formErrorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
            ],
            // キーワード、ユーザー名、組織名の入力フォーム
            TextFormField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.advanced_search_keyword,
              ),
              initialValue: searchState.keyword,
              onChanged: (value) =>
                  ref.read(searchStateProvider.notifier).updateKeyword(value),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.advanced_search_username,
              ),
              initialValue: searchState.username,
              onChanged: (value) =>
                  ref.read(searchStateProvider.notifier).updateUsername(value),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.advanced_search_organization,
              ),
              initialValue: searchState.organization,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateOrganization(value),
            ),
            // 検索対象の選択スイッチ
            const SizedBox(height: 16),
            SwitchListTile(
              title:
                  Text(AppLocalizations.of(context)!.advanced_search_in_name),
              value: searchState.searchInName,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInName(value),
            ),
            SwitchListTile(
              title: Text(
                AppLocalizations.of(context)!.advanced_search_in_description,
              ),
              value: searchState.searchInDescription,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInDescription(value),
            ),
            SwitchListTile(
              title: Text(
                AppLocalizations.of(context)!.advanced_search_in_topics,
              ),
              value: searchState.searchInTopics,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInTopics(value),
            ),
            SwitchListTile(
              title: Text(
                AppLocalizations.of(context)!.advanced_search_in_readme,
              ),
              value: searchState.searchInReadme,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInReadme(value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performSearch,
              child: Text(AppLocalizations.of(context)!.advanced_search_button),
            ),
          ],
        ),
      ),
    );
  }
}
