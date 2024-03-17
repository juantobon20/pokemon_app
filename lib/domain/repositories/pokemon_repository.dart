import 'package:pokemon_app/domain/domain.dart';

abstract class PokemonRepository {

  Future<List<PokemonView>> getPokemons({ int offset = 0, int limit = 10 });

  Future<PokemonView> getPokemonById({ required int id });

  Future<List<FilterData>> getFilters({ 
    required String endPoint,
    int offset = 0, 
    int limit = 10
  });

  Future<List<PokemonView>> getPokemonsByFilter({ 
    required String endPoint,
    required String name
  });

  Future<void> toggleFavorite(PokemonView pokemonView);

  Future<bool> isPokemonFavorite(int pokemonId);

  Future<List<PokemonView>> loadFavoritesPokemons({ int limit = 10, int offset = 0});
}