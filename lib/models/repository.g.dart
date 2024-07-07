// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryImpl _$$RepositoryImplFromJson(Map<String, dynamic> json) =>
    _$RepositoryImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      language: json['language'] as String?,
      stars: (json['stargazers_count'] as num).toInt(),
      watchers: (json['watchers_count'] as num).toInt(),
      forks: (json['forks_count'] as num).toInt(),
      issues: (json['open_issues_count'] as num).toInt(),
    );

Map<String, dynamic> _$$RepositoryImplToJson(_$RepositoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'owner': instance.owner,
      'description': instance.description,
      'language': instance.language,
      'stargazers_count': instance.stars,
      'watchers_count': instance.watchers,
      'forks_count': instance.forks,
      'open_issues_count': instance.issues,
    };
