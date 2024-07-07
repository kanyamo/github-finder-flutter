import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class Repository with _$Repository {
  factory Repository({
    required String name,
    required String ownerAvatarUrl,
    required String language,
    required int stars,
    required int watchers,
    required int forks,
    required int issues,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);
}
