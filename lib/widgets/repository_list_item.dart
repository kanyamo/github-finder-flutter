import 'package:flutter/material.dart';
import '../models/repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      subtitle: Text(
        AppLocalizations.of(context)!
            .repository_list_item_stars(repository.stars),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(repository.owner.avatarUrl),
      ),
      onTap: onTap,
    );
  }
}
