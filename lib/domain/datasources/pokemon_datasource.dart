import 'package:pokemon_app/data/data.dart';

abstract class PokemonDatasource {

  Future<List<PokemonDetailResponse>> getPokemons({ int offset = 0, int limit = 10 });

  Future<PokemonDetailResponse> getPokemonById({ required int id });
}