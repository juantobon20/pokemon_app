part of 'pokemon_detail_screen_cubit.dart';

class PokemonDetailScreenState {
  final bool isLoading;
  final PokemonEntity? pokemonEntity;
  final ErrorData? errorData;

  PokemonDetailScreenState({
    this.isLoading = false, 
    this.pokemonEntity,
    this.errorData
  });

  PokemonDetailScreenState copyWith({
    bool? isLoading,
    PokemonEntity? pokemonEntity,
    ErrorData? errorData
  }) => PokemonDetailScreenState(
    isLoading: isLoading ?? this.isLoading,
    pokemonEntity: pokemonEntity,
    errorData: errorData
  );
}
