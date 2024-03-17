import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/data/data.dart';
import 'package:pokemon_app/domain/domain.dart';

import 'pokemon_repository_imp_test.mocks.dart';

@GenerateMocks([
  PokemonDatasource
])
main() {
  late PokemonRepository pokemonRepository;
  late PokemonDatasource pokemonDatasource;

  setUp(() {
    pokemonDatasource = MockPokemonDatasource();
    pokemonRepository = PokemonRepositoryImpl(pokemonDatasource: pokemonDatasource);
  });

  group('PokemonRepository Test', () {
    test('given a pokemonId when the get is called it should get the pokemon data', () async {
    const int pokemonId = 1;
    PokemonDetailResponse mockResponse = PokemonDetailResponse(
      abilities: [], 
      height: 0, 
      id: 1, 
      name: 'mock', 
      types: [], 
      weight: 0
    );

    when(pokemonDatasource.getPokemonById(id: pokemonId))
      .thenAnswer((_) async => mockResponse);

    final response = await pokemonRepository.getPokemonById(id: pokemonId);
    expect(mockResponse.id, response.id);
    expect(mockResponse.name, response.name);
  });

    test('when the getPokemons is called it should get the pokemons data', () async {
      PokemonResponse mockResponse = PokemonResponse(
        name: 'mock', 
        url: 'https://example.co/api/v2/pokemon/1/'
      );

      when(pokemonDatasource.getPokemons())
        .thenAnswer((_) async => [mockResponse]);

      final response = await pokemonRepository.getPokemons();
      expect(mockResponse.name, response.first.name);
    });

    test('given a endpoint when the getFilters is called it should get the pokemons data', () async {
      const endpoint = "type";
      PokemonFilterResponse mockResponse = PokemonFilterResponse(
        name: 'mock', 
        url: 'https://example.co/api/v2/pokemon/1/'
      );

      when(pokemonDatasource.getFilters(endPoint: endpoint))
        .thenAnswer((_) async => [mockResponse]);

      final response = await pokemonRepository.getFilters(endPoint: endpoint);
      expect(mockResponse.name, response.first.name);
    });
  });
}