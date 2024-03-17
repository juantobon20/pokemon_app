import 'package:pokemon_app/config/extensions/string_extension.dart';
import 'package:pokemon_app/domain/domain.dart';

class PokemonDetailResponse {
    final List<Ability> abilities;
    final int height;
    final int id;
    final String name;
    final List<Type> types;
    final int weight;

    PokemonDetailResponse({
        required this.abilities,
        required this.height,
        required this.id,
        required this.name,
        required this.types,
        required this.weight,
    });

    factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) => PokemonDetailResponse(
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        height: json["height"],
        id: json["id"],
        name: json["name"],
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
        weight: json["weight"],
    );
}

class Ability {
    final Species ability;
    final bool isHidden;
    final int slot;

    Ability({
        required this.ability,
        required this.isHidden,
        required this.slot,
    });

    factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        ability: Species.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
    );

    Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
    };
}

class Species {
    final String name;
    final String url;

    Species({
        required this.name,
        required this.url,
    });

    factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

class Type {
    final int slot;
    final Species type;

    Type({
        required this.slot,
        required this.type,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}

extension PokemonMapper on PokemonDetailResponse {

  PokemonView mapper() => PokemonView(
    id: id,
    name: name, 
    img: id.getImageUrl(),
    abilities: abilities.map((e) => e.ability.name).toList(),
    types: types.map((e) => e.type.name).toList(),
    weightFormated: '${(weight / 10).toStringAsFixed(1)} Kg',
    sizeFormated: '${(height / 10).toStringAsFixed(1)} M'
  );
}