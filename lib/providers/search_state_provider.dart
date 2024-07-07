import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchState {
  final String keyword;
  final String username;
  final String organization;
  final bool searchInName;
  final bool searchInDescription;
  final bool searchInTopics;
  final bool searchInReadme;

  SearchState({
    this.keyword = '',
    this.username = '',
    this.organization = '',
    this.searchInName = true,
    this.searchInDescription = true,
    this.searchInTopics = true,
    this.searchInReadme = false,
  });

  SearchState copyWith({
    String? keyword,
    String? username,
    String? organization,
    bool? searchInName,
    bool? searchInDescription,
    bool? searchInTopics,
    bool? searchInReadme,
  }) {
    return SearchState(
      keyword: keyword ?? this.keyword,
      username: username ?? this.username,
      organization: organization ?? this.organization,
      searchInName: searchInName ?? this.searchInName,
      searchInDescription: searchInDescription ?? this.searchInDescription,
      searchInTopics: searchInTopics ?? this.searchInTopics,
      searchInReadme: searchInReadme ?? this.searchInReadme,
    );
  }

  String buildSearchQuery({bool simpleSearch = false}) {
    List<String> queryParts = [keyword];

    if (!simpleSearch) {
      if (username.isNotEmpty) queryParts.add('user:$username');
      if (organization.isNotEmpty) queryParts.add('org:$organization');

      List<String> inParts = [];
      if (searchInName) inParts.add('name');
      if (searchInDescription) inParts.add('description');
      if (searchInTopics) inParts.add('topics');
      if (searchInReadme) inParts.add('readme');

      if (inParts.isNotEmpty) {
        queryParts.add('in:${inParts.join(',')}');
      }
    }

    return queryParts.join(' ');
  }
}

class SearchStateNotifier extends StateNotifier<SearchState> {
  SearchStateNotifier() : super(SearchState());

  void updateKeyword(String keyword) {
    state = state.copyWith(keyword: keyword);
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  void updateOrganization(String organization) {
    state = state.copyWith(organization: organization);
  }

  void updateSearchInName(bool value) {
    state = state.copyWith(searchInName: value);
  }

  void updateSearchInDescription(bool value) {
    state = state.copyWith(searchInDescription: value);
  }

  void updateSearchInTopics(bool value) {
    state = state.copyWith(searchInTopics: value);
  }

  void updateSearchInReadme(bool value) {
    state = state.copyWith(searchInReadme: value);
  }

  void resetState() {
    state = SearchState();
  }
}

final searchStateProvider =
    StateNotifierProvider<SearchStateNotifier, SearchState>(
  (ref) => SearchStateNotifier(),
);
