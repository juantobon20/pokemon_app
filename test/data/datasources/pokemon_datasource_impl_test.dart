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

  setUp(() {
    pokemonDatasource = PokemonDatasourceImpl();
  });

  test('get pokemon by id test', () async {
    const int id = 1;
    final dioProvider = DioProvider(
      dio: MockDio()
    );

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
      .thenAnswer((_) async => Future.value(mock));
    
    final response = await pokemonDatasource.getPokemonById(id: 1);

    expect(response, pokemonDetail);
  });
}