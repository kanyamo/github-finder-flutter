import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/github_repositories_provider.dart';
import '../providers/search_state_provider.dart';

class AdvancedSearchScreen extends ConsumerStatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  ConsumerState<AdvancedSearchScreen> createState() =>
      _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends ConsumerState<AdvancedSearchScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid() {
    final searchState = ref.read(searchStateProvider);
    return searchState.keyword.isNotEmpty ||
        searchState.username.isNotEmpty ||
        searchState.organization.isNotEmpty;
  }

  void _performSearch() {
    if (_formKey.currentState!.validate() && _isFormValid()) {
      final searchState = ref.read(searchStateProvider);
      final query = searchState.buildSearchQuery();
      ref.read(githubRepositoriesProvider.notifier).searchRepositories(query);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Search')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Search keyword'),
              initialValue: searchState.keyword,
              onChanged: (value) =>
                  ref.read(searchStateProvider.notifier).updateKeyword(value),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              initialValue: searchState.username,
              onChanged: (value) =>
                  ref.read(searchStateProvider.notifier).updateUsername(value),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Organization'),
              initialValue: searchState.organization,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateOrganization(value),
            ),
            SwitchListTile(
              title: const Text('Search in repository name'),
              value: searchState.searchInName,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInName(value),
            ),
            SwitchListTile(
              title: const Text('Search in description'),
              value: searchState.searchInDescription,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInDescription(value),
            ),
            SwitchListTile(
              title: const Text('Search in topics'),
              value: searchState.searchInTopics,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInTopics(value),
            ),
            SwitchListTile(
              title: const Text('Search in README'),
              value: searchState.searchInReadme,
              onChanged: (value) => ref
                  .read(searchStateProvider.notifier)
                  .updateSearchInReadme(value),
            ),
            ElevatedButton(
              onPressed: _performSearch,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
