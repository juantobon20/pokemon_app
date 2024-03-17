
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/domain.dart';
import '../data.dart';

class PokemonDatasourceImpl implements PokemonDatasource {

  late Future<Isar> db;
  PokemonDatasourceImpl() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PokemonEntitySchema], 
        directory: dir.path
      );
    }

    return Future.value(Isar.getInstance());
  }

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

  @override
  Future<bool> isPokemonFavorite(int pokemonId) async {
    final isar = await db;
    
    final PokemonEntity? isFavoriteMovie = await isar.pokemonEntitys
      .filter()
      .idEqualTo(pokemonId)
      .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<PokemonEntity>> loadFavoritesPokemons({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return await isar.pokemonEntitys.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }

  @override
  Future<void> toggleFavorite(PokemonEntity pokemonEntity) async {
    final isar = await db;

    final PokemonEntity? favoritePokemon = await isar.pokemonEntitys
      .filter()
      .idEqualTo(pokemonEntity.id)
      .findFirst();

    if (favoritePokemon != null) {
      isar.writeTxnSync(() => isar.pokemonEntitys.deleteSync(favoritePokemon.uId));
      return;
    }

    isar.writeTxnSync(() => isar.pokemonEntitys.putSync(pokemonEntity));
  }
}