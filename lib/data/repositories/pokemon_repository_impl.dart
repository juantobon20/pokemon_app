import 'package:pokemon_app/data/data.dart';
import 'package:pokemon_app/domain/domain.dart';

class PokemonRepositoryImpl implements PokemonRepository {

  final PokemonDatasource _pokemonDatasource;

  PokemonRepositoryImpl({
    required PokemonDatasource pokemonDatasource
  }) : _pokemonDatasource = pokemonDatasource;

  @override
  Future<PokemonEntity> getPokemonById({ required int id }) async {
    final pokemonDetailResponse = await _pokemonDatasource.getPokemonById(id: id);

    return pokemonDetailResponse.mapper();
  }

  @override
  Future<List<PokemonEntity>> getPokemons({int offset = 0, int limit = 10}) async {
    final pokemonsDetailResponse = await _pokemonDatasource.getPokemons(offset: offset, limit: limit);
    return pokemonsDetailResponse.map((e) => e.mapper()).toList();
  }
  
  @override
  Future<List<FilterData>> getFilters({required String endPoint, int offset = 0, int limit = 10}) async {
    final pokemonsFilterResponse = await _pokemonDatasource.getFilters(endPoint: endPoint);
    return pokemonsFilterResponse.map((e) => e.mapper(endPoint.getFilterType())).toList();
  }

  @override
  Future<List<PokemonEntity>> getPokemonsByFilter({required String endPoint, required String name}) async {
    final pokemonsDetailResponse = await _pokemonDatasource.getPokemonsByFilter(endPoint: endPoint, name: name);
    return pokemonsDetailResponse.map((e) => e.mapper()).toList();
  }
}