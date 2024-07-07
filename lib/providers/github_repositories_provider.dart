import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/repository.dart';

final githubRepositoriesProvider = StateNotifierProvider<
    GitHubRepositoriesNotifier, AsyncValue<List<Repository>>>((ref) {
  return GitHubRepositoriesNotifier();
});

class GitHubRepositoriesNotifier
    extends StateNotifier<AsyncValue<List<Repository>>> {
  GitHubRepositoriesNotifier() : super(const AsyncValue.data([]));

  Future<void> searchRepositories(String query) async {
    state = const AsyncValue.loading();

    try {
      final encodedQuery = Uri.encodeComponent(query);
      final response = await http.get(
        Uri.parse('https://api.github.com/search/repositories?q=$encodedQuery'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final repositories = (data['items'] as List)
            .map((item) => Repository.fromJson(item))
            .toList();
        state = AsyncValue.data(repositories);
      } else {
        state =
            AsyncValue.error('Failed to load repositories', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error('An error occurred: $e', stack);
    }
  }
}
