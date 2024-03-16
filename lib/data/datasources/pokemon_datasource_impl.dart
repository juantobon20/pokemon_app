import 'package:dio/dio.dart';

import '../../domain/domain.dart';
import '../data.dart';

class PokemonDatasourceImpl implements PokemonDatasource {

  @override
  Future<PokemonDetailResponse> getPokemonById({required String urlString}) async {
    final response = await DioProvider(
      dio: Dio(BaseOptions(baseUrl: urlString))
    ).get('');

    return PokemonDetailResponse.fromJson(response);
  }

  @override
  Future<List<PokemonDetailResponse>> getPokemons({int offset = 0, int limit = 10}) async {
    final response = await DioProvider().get('/pokemon?offset=$offset&limit=$limit');
    final pokemons = PokemonsResponse.fromJson(response).pokemons;
    return Stream.fromIterable(pokemons)
      .asyncMap((pokemon) async => await getPokemonById(urlString: pokemon.url) )
      .toList(); 
  }
}