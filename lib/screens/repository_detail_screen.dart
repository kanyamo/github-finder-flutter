import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/repository.dart';
import '../providers/search_state_provider.dart';
import '../providers/github_repositories_provider.dart';
import '../widgets/chip.dart';

class RepositoryDetailScreen extends ConsumerWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(repository.owner.avatarUrl),
                  radius: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repository.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        repository.fullName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (repository.description != null) ...[
              Text(
                repository.description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
            ],
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                RepositoryDetailChip(
                  icon: Icons.code,
                  label: 'Language',
                  value: repository.language ?? 'N/A',
                ),
                RepositoryDetailChip(
                  icon: Icons.star,
                  label: 'Stars',
                  value: repository.stars.toString(),
                ),
                RepositoryDetailChip(
                  icon: Icons.remove_red_eye,
                  label: 'Watchers',
                  value: repository.watchers.toString(),
                ),
                RepositoryDetailChip(
                  icon: Icons.call_split,
                  label: 'Forks',
                  value: repository.forks.toString(),
                ),
                RepositoryDetailChip(
                  icon: Icons.error_outline,
                  label: 'Issues',
                  value: repository.issues.toString(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // この場限りの検索条件であり、詳細検索条件(providerの状態)は変更しない
                  final query = ref
                      .read(searchStateProvider)
                      .copyWith(
                        username: repository.owner.login,
                        keyword: '',
                      )
                      .buildSearchQuery();
                  ref
                      .read(githubRepositoriesProvider.notifier)
                      .searchRepositories(query);
                  Navigator.of(context).pop();
                },
                child: const Text('このユーザーが作成したリポジトリ一覧を検索'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
