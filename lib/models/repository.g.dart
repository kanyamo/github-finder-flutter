// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepositoryImpl _$$RepositoryImplFromJson(Map<String, dynamic> json) =>
    _$RepositoryImpl(
      name: json['name'] as String,
      ownerAvatarUrl: json['ownerAvatarUrl'] as String,
      language: json['language'] as String,
      stars: (json['stars'] as num).toInt(),
      watchers: (json['watchers'] as num).toInt(),
      forks: (json['forks'] as num).toInt(),
      issues: (json['issues'] as num).toInt(),
    );

Map<String, dynamic> _$$RepositoryImplToJson(_$RepositoryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ownerAvatarUrl': instance.ownerAvatarUrl,
      'language': instance.language,
      'stars': instance.stars,
      'watchers': instance.watchers,
      'forks': instance.forks,
      'issues': instance.issues,
    };
