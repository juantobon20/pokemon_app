import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/data/data.dart';
import 'package:pokemon_app/domain/domain.dart';

import 'pokemon_datasource_impl_test.mocks.dart';

@GenerateMocks([
  Dio,
  DioProvider
])
void main() {
  late PokemonDatasource pokemonDatasource;
  late DioProvider dioProvider;

  setUp(() {
    dioProvider = MockDioProvider();
    pokemonDatasource = PokemonDatasourceImpl(
      dioProvider: dioProvider
    );
  });

  test('given a pokemonId when the get is called it should get the pokemon data', () async {
    const int id = 1;

    Map<String, dynamic> mock = {
      "abilities" : [],
      "height" : 0,
      "id" : 1,
      "name" : "mock",
      "types" : [],
      "weight" : 1
    };

    final pokemonDetail = PokemonDetailResponse.fromJson(mock);

    when(dioProvider.get('/pokemon/$id'))
      .thenAnswer((_) async => mock);
    
    final response = await pokemonDatasource.getPokemonById(id: 1);

    expect(response.name, pokemonDetail.name);
    expect(response.weight, pokemonDetail.weight);
  });
}