import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/github_repositories_provider.dart';
import '../widgets/repository_list_item.dart';
import 'repository_detail_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesState = ref.watch(githubRepositoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repository Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search repositories',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref
                      .read(githubRepositoriesProvider.notifier)
                      .searchRepositories(value);
                }
              },
            ),
          ),
          Expanded(
            child: repositoriesState.when(
              data: (repositories) {
                if (repositories.isEmpty) {
                  return const Center(child: Text('No repositories found'));
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
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
