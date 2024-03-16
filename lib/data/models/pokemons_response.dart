class PokemonsResponse {
    final int count;
    final String next;
    final dynamic previous;
    final List<PokemonResponse> pokemons;

    PokemonsResponse({
        required this.count,
        required this.next,
        required this.previous,
        required this.pokemons,
    });

    factory PokemonsResponse.fromJson(Map<String, dynamic> json) => PokemonsResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        pokemons: List<PokemonResponse>.from(json["results"].map((pokemon) => PokemonResponse.fromJson(pokemon))),
    );
}

class PokemonResponse {
    final String name;
    final String url;

    PokemonResponse({
        required this.name,
        required this.url,
    });

    factory PokemonResponse.fromJson(Map<String, dynamic> json) => PokemonResponse(
        name: json["name"],
        url: json["url"],
    );
}