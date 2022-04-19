// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokebag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokebag _$PokebagFromJson(Map<String, dynamic> json) => Pokebag(
      json['id'] as String,
      json['name'] as String,
      PokemonDetailResponse.fromJson(
          json['dataPokemon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokebagToJson(Pokebag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.nameGiven,
      'dataPokemon': instance.dataPokemon,
    };
