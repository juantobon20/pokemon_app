import 'package:pokemon_app/data/data.dart';
import 'package:pokemon_app/data/models/pokemon_entity.dart';
import 'package:pokemon_app/domain/domain.dart';

class PokemonRepositoryImpl implements PokemonRepository {

  final PokemonDatasource _pokemonDatasource;

  PokemonRepositoryImpl({
    required PokemonDatasource pokemonDatasource
  }) : _pokemonDatasource = pokemonDatasource;

  @override
  Future<PokemonView> getPokemonById({ required int id }) async {
    final pokemonDetailResponse = await _pokemonDatasource.getPokemonById(id: id);

    return pokemonDetailResponse.mapper();
  }

  @override
  Future<List<PokemonView>> getPokemons({int offset = 0, int limit = 10}) async {
    final pokemonsDetailResponse = await _pokemonDatasource.getPokemons(offset: offset, limit: limit);
    return pokemonsDetailResponse.map((e) => e.mapper()).toList();
  }
  
  @override
  Future<List<FilterData>> getFilters({required String endPoint, int offset = 0, int limit = 10}) async {
    final pokemonsFilterResponse = await _pokemonDatasource.getFilters(endPoint: endPoint);
    return pokemonsFilterResponse.map((e) => e.mapper(endPoint.getFilterType())).toList();
  }

  @override
  Future<List<PokemonView>> getPokemonsByFilter({required String endPoint, required String name}) async {
    final pokemonsDetailResponse = await _pokemonDatasource.getPokemonsByFilter(endPoint: endPoint, name: name);
    return pokemonsDetailResponse.map((e) => e.mapper()).toList();
  }
  
  @override
  Future<bool> isPokemonFavorite(int pokemonId) => _pokemonDatasource.isPokemonFavorite(pokemonId);
  
  @override
  Future<List<PokemonView>> loadFavoritesPokemons({int limit = 10, int offset = 0}) async {
    final pokemonsEntityResponse = await _pokemonDatasource.loadFavoritesPokemons(limit: limit, offset: offset);
    return pokemonsEntityResponse.map((e) => e.mapper()).toList();
  }
  
  @override
  Future<void> toggleFavorite(PokemonView pokemonView) => _pokemonDatasource.toggleFavorite(pokemonView.mapper());
}