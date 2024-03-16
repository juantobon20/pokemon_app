import 'package:pokemon_app/domain/domain.dart';

abstract class PokemonRepository {

  Future<List<PokemonEntity>> getPokemons({ int offset = 0, int limit = 10 });

  Future<PokemonEntity> getPokemonById({ required String urlString });
}