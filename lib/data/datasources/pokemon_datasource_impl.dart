
import 'package:pokemon_app/data/models/pokemons_by_filter_response.dart';

import '../../domain/domain.dart';
import '../data.dart';

class PokemonDatasourceImpl implements PokemonDatasource {

  @override
  Future<PokemonDetailResponse> getPokemonById({required int id}) async {
    final response = await DioProvider().get('/pokemon/$id');

    return PokemonDetailResponse.fromJson(response);
  }

  @override
  Future<List<PokemonResponse>> getPokemons({int offset = 0, int limit = 10}) async {
    final response = await DioProvider().get('/pokemon?offset=$offset&limit=$limit');
    return PokemonsResponse.fromJson(response).pokemons;
  }
  
  @override
  Future<List<PokemonFilterResponse>> getFilters({
    required String endPoint,
    int offset = 0, 
    int limit = 10
  }) async {
    final response = await DioProvider().get('/$endPoint?offset=$offset&limit=$limit');
    return PokemonsFilterResponse.fromJson(response).results;
  }

  @override
  Future<List<PokemonResponse>> getPokemonsByFilter({required String endPoint, required String name}) async {
    final response = await DioProvider().get('/$endPoint/$name');
    return PokemonsByFilterResponse.fromJson(response).pokemons; 
  }
}