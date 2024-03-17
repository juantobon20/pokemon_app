import 'pokemons_response.dart';

class PokemonsByFilterResponse {
    final List<PokemonResponse> pokemons;

    PokemonsByFilterResponse({
        required this.pokemons, 
    });

    factory PokemonsByFilterResponse.fromJson(Map<String, dynamic> json) => PokemonsByFilterResponse(
        pokemons: List<PokemonResponse>.from(json["pokemon"].map((x) => PokemonResponse.fromJson(x["pokemon"]))),
    );
}
