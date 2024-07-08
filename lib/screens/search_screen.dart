import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/github_repositories_provider.dart';
import '../providers/search_state_provider.dart';
import '../widgets/repository_list_item.dart';
import 'repository_detail_screen.dart';
import 'advanced_search_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController =
        TextEditingController(text: ref.read(searchStateProvider).keyword);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final searchState = ref.read(searchStateProvider);
    final query = searchState.buildSearchQuery(simpleSearch: true);
    if (query.isNotEmpty) {
      ref.read(githubRepositoriesProvider.notifier).searchRepositories(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repositoriesState = ref.watch(githubRepositoriesProvider);
    final searchState = ref.watch(searchStateProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_searchController.text != searchState.keyword) {
        _searchController.text = searchState.keyword;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.search_screen_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvancedSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!
                    .search_screen_search_repositories,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              controller: _searchController,
              onChanged: (value) {
                ref.read(searchStateProvider.notifier).updateKeyword(value);
              },
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Expanded(
            child: repositoriesState.when(
              data: (repositories) {
                if (repositories.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .search_screen_no_repositories,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: repositories.length,
                  itemBuilder: (context, index) {
                    final repo = repositories[index];
                    return RepositoryListItem(
                      repository: repo,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RepositoryDetailScreen(repository: repo),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .search_screen_error(error.toString()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
