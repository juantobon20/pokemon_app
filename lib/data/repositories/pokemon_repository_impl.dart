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
}