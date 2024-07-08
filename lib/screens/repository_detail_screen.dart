import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_finder_flutter/widgets/conditional_image.dart';
import '../models/repository.dart';
import '../providers/search_state_provider.dart';
import '../providers/github_repositories_provider.dart';
import '../widgets/chip.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// リポジトリ詳細画面
/// 初期化時に表示するリポジトリ情報を受け取る
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
                // テストモードでHTTP通信ができない場合は、代わりにローカルから画像を読み込む
                ConditionalCircleAvatar(
                  networkUrl: repository.owner.avatarUrl,
                  assetPath: 'assets/images/default_user.png',
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
                  label:
                      AppLocalizations.of(context)!.repository_detail_language,
                  value: repository.language ?? 'N/A',
                ),
                RepositoryDetailChip(
                  icon: Icons.star,
                  label: AppLocalizations.of(context)!.repository_detail_stars,
                  value: repository.stars.toString(),
                ),
                RepositoryDetailChip(
                  icon: Icons.remove_red_eye,
                  label:
                      AppLocalizations.of(context)!.repository_detail_watchers,
                  value: repository.watchers.toString(),
                ),
                RepositoryDetailChip(
                  icon: Icons.call_split,
                  label: AppLocalizations.of(context)!.repository_detail_forks,
                  value: repository.forks.toString(),
                ),
                RepositoryDetailChip(
                  icon: Icons.error_outline,
                  label: AppLocalizations.of(context)!.repository_detail_issues,
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
                child: Text(
                  AppLocalizations.of(context)!
                      .repository_detail_search_user_repos,
                ),
              ),
            ),
            if (repository.htmlUrl != null) ...[
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_browser),
                  onPressed: () {
                    _launchURL(Uri.parse(repository.htmlUrl!), context);
                  },
                  label: Text(
                    AppLocalizations.of(context)!
                        .repository_detail_view_on_github,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
