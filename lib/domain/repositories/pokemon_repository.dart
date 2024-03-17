import 'package:pokemon_app/domain/domain.dart';

abstract class PokemonRepository {

  Future<List<PokemonEntity>> getPokemons({ int offset = 0, int limit = 10 });

  Future<PokemonEntity> getPokemonById({ required int id });

  Future<List<FilterData>> getFilters({ 
    required String endPoint,
    int offset = 0, 
    int limit = 10
  });

  Future<List<PokemonEntity>> getPokemonsByFilter({ 
    required String endPoint,
    required String name
  });
}