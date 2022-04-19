import 'package:json_annotation/json_annotation.dart';
import 'package:pokebag_flutter/app/data/models/response/pokemon/detail/poke-detail_response.dart';

part 'pokebag.g.dart';

@JsonSerializable()
class Pokebag {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String nameGiven;

  @JsonKey(name: 'dataPokemon')
  final PokemonDetailResponse dataPokemon;

  Pokebag(
    this.id,
    this.nameGiven,
    this.dataPokemon,
  );

  factory Pokebag.fromJson(Map<String, dynamic> json) =>
      _$PokebagFromJson(json);

  Map<String, dynamic> toJson() => _$PokebagToJson(this);
}