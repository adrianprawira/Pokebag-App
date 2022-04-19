import 'package:json_annotation/json_annotation.dart';

part 'poke-detail_response.g.dart';

@JsonSerializable()
class PokemonDetailResponse {
  @JsonKey(name: 'abilities')
  final List<Abilities> abilities;

  @JsonKey(name: 'height')
  final int height;

  @JsonKey(name: 'moves')
  final List<Moves> moves;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'sprites')
  final Sprites sprites;

  @JsonKey(name: 'types')
  final List<Types> types;

  @JsonKey(name: 'weight')
  final int weight;

  PokemonDetailResponse(this.abilities, this.moves, this.name, this.sprites,
      this.types, this.height, this.weight);

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailResponseToJson(this);
}

@JsonSerializable()
class Abilities {
  @JsonKey(name: 'ability')
  final Ability ability;

  @JsonKey(name: 'is_hidden')
  final bool hiddenAbility;

  @JsonKey(name: 'slot')
  final int slot;

  Abilities(this.ability, this.hiddenAbility, this.slot);

  factory Abilities.fromJson(Map<String, dynamic> json) =>
      _$AbilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$AbilitiesToJson(this);
}

@JsonSerializable()
class Ability {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  Ability(this.name, this.url);

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
class Moves {
  @JsonKey(name: 'move')
  final Move move;

  Moves(this.move);

  factory Moves.fromJson(Map<String, dynamic> json) => _$MovesFromJson(json);

  Map<String, dynamic> toJson() => _$MovesToJson(this);
}

@JsonSerializable()
class Move {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  Move(this.name, this.url);

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);
}

@JsonSerializable()
class Sprites {
  @JsonKey(name: 'other')
  final Other avatar;

  Sprites(this.avatar);

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);

  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}

@JsonSerializable()
class Other {
  @JsonKey(name: 'official-artwork')
  final OfficialArtwork officialArtwork;

  Other(this.officialArtwork);

  factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);

  Map<String, dynamic> toJson() => _$OtherToJson(this);

  static final empty = Other(OfficialArtwork('helo'));
}

@JsonSerializable()
class OfficialArtwork {
  @JsonKey(name: 'front_default')
  final dynamic picture;

  OfficialArtwork(this.picture);

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);

  static final empty = OfficialArtwork('helo');
}

@JsonSerializable()
class Types {
  @JsonKey(name: 'slot')
  final int slot;

  @JsonKey(name: 'type')
  final PokemonType type;

  Types(this.slot, this.type);

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);

  Map<String, dynamic> toJson() => _$TypesToJson(this);
}

@JsonSerializable()
class PokemonType {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  PokemonType(this.name, this.url);

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypeToJson(this);
}
