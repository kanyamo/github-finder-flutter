import 'package:flutter/material.dart';
import '../models/repository.dart';

class RepositoryListItem extends StatelessWidget {
  final Repository repository;
  final VoidCallback onTap;

  const RepositoryListItem({
    super.key,
    required this.repository,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repository.name),
      subtitle: Text('Stars: ${repository.stars}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(repository.owner.avatarUrl),
      ),
      onTap: onTap,
    );
  }
}
