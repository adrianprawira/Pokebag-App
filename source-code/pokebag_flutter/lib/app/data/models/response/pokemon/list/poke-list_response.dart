import 'package:json_annotation/json_annotation.dart';

part 'poke-list_response.g.dart';

@JsonSerializable()
class PokemonListResponse {
  @JsonKey(name: 'count')
  final int totalData;

  @JsonKey(name: 'next')
  final dynamic nextPage;

  @JsonKey(name: 'previous')
  final dynamic previousPage;

  @JsonKey(name: 'results')
  final List<Pokemon> listPokemon;

  PokemonListResponse(
    this.totalData,
    this.nextPage,
    this.previousPage,
    this.listPokemon,
  );

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListResponseToJson(this);
}

@JsonSerializable()
class Pokemon {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  Pokemon(
    this.name,
    this.url,
  );

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}