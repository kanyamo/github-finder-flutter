import 'package:flutter/material.dart';
import '../models/repository.dart';

class RepositoryDetailScreen extends StatelessWidget {
  final Repository repository;

  const RepositoryDetailScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: Padding(
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
                  child: Text(
                    repository.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Language: ${repository.language}'),
            Text('Stars: ${repository.stars}'),
            Text('Watchers: ${repository.watchers}'),
            Text('Forks: ${repository.forks}'),
            Text('Issues: ${repository.issues}'),
          ],
        ),
      ),
    );
  }
}
