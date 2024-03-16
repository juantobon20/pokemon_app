
import '../../config/config.dart';
import '../../domain/domain.dart';
import '../data.dart';

class PokemonDatasourceImpl implements PokemonDatasource {

  @override
  Future<PokemonDetailResponse> getPokemonById({required int id}) async {
    final response = await DioProvider().get('/pokemon/$id');

    return PokemonDetailResponse.fromJson(response);
  }

  @override
  Future<List<PokemonDetailResponse>> getPokemons({int offset = 0, int limit = 10}) async {
    final response = await DioProvider().get('/pokemon?offset=$offset&limit=$limit');
    final pokemons = PokemonsResponse.fromJson(response).pokemons;
    return Stream.fromIterable(pokemons)
      .asyncMap((pokemon) async => await getPokemonById(id: pokemon.url.getPokemonId()) )
      .toList(); 
  }
}