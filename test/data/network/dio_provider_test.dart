import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/data/data.dart';

import '../datasources/pokemon_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  late Dio dio;
  late DioProvider dioProvider;

  setUp(() {
    dio = MockDio();
    dioProvider = DioProvider(dio: dio);
  });

  test('given a pokemonId when the get is called it should get the pokemon data.', () async {
      // Define expected Pokemon ID and details
      const int expectedId = 1;
      const String expectedName = 'Bulbasaur';

      final expectedResponse = {
        'id': expectedId,
        'name': expectedName,
      };

      final requestOptions = RequestOptions(path: '/pokemon/$expectedId');

      // Stub Dio.get to return the mock response
      when(dio.get('/pokemon/$expectedId'))
          .thenAnswer((_) => Future.value(Response(data: expectedResponse, requestOptions: requestOptions)));

      // Call getPokemonById
      final actualResponse = await dioProvider.get('/pokemon/$expectedId');

      // Verify response matches expectations
      expect(actualResponse['id'], expectedId);
      expect(actualResponse['name'], expectedName);
  });
}