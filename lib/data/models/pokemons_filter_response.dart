import 'package:pokemon_app/domain/domain.dart';

class PokemonsFilterResponse {
    final int count;
    final String? next;
    final String? previous;
    final List<PokemonFilterResponse> results;

    PokemonsFilterResponse({
        required this.count,
        this.next,
        this.previous,
        required this.results,
    });

    factory PokemonsFilterResponse.fromJson(Map<String, dynamic> json) => PokemonsFilterResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonFilterResponse>.from(json["results"].map((x) => PokemonFilterResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class PokemonFilterResponse {
    final String name;
    final String url;

    PokemonFilterResponse({
        required this.name,
        required this.url,
    });

    factory PokemonFilterResponse.fromJson(Map<String, dynamic> json) => PokemonFilterResponse(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

extension PokemonFilterMapper on PokemonFilterResponse {

  FilterData mapper(FilterType filterType) => FilterData(
    name: name, 
    filterType: filterType
  );
}