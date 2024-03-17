import 'package:pokemon_app/data/data.dart';

abstract class PokemonDatasource {

  Future<List<PokemonResponse>> getPokemons({ int offset = 0, int limit = 10 });

  Future<PokemonDetailResponse> getPokemonById({ required int id });

  Future<List<PokemonFilterResponse>> getFilters({ 
    required String endPoint,
    int offset = 0, 
    int limit = 10
  });

  Future<List<PokemonResponse>> getPokemonsByFilter({ 
    required String endPoint,
    required String name
  });
}