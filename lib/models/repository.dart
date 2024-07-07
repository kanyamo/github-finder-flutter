import 'package:freezed_annotation/freezed_annotation.dart';
import 'owner.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class Repository with _$Repository {
  factory Repository({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
    required Owner owner,
    required String? description,
    required String? language,
    @JsonKey(name: 'stargazers_count') required int stars,
    @JsonKey(name: 'watchers_count') required int watchers,
    @JsonKey(name: 'forks_count') required int forks,
    @JsonKey(name: 'open_issues_count') required int issues,
    @JsonKey(name: 'html_url') required String? htmlUrl,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
}
