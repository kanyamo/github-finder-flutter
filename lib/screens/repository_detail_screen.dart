import 'package:flutter/material.dart';
import '../models/repository.dart';
import '../widgets/chip.dart';

class RepositoryDetailScreen extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
