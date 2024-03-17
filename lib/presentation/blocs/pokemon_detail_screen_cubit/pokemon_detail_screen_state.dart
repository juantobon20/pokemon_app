part of 'pokemon_detail_screen_cubit.dart';

class PokemonDetailScreenState {
  final bool isLoading;
  final PokemonView? pokemonView;
  final ErrorData? errorData;

  PokemonDetailScreenState({
    this.isLoading = false, 
    this.pokemonView,
    this.errorData
  });

  PokemonDetailScreenState copyWith({
    bool? isLoading,
    PokemonView? pokemonEntity,
    ErrorData? errorData
  }) => PokemonDetailScreenState(
    isLoading: isLoading ?? this.isLoading,
    pokemonView: pokemonEntity,
    errorData: errorData
  );
}
