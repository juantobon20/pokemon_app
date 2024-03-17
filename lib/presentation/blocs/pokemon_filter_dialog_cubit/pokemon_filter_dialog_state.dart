part of 'pokemon_filter_dialog_cubit.dart';

class PokemonFilterDialogState extends Equatable {
  final bool isLoading;
  final List<FilterData> types;
  final List<FilterData> abilities;
  final ErrorData? errorData;

  const PokemonFilterDialogState({
    this.isLoading = false,
    this.types = const [], 
    this.abilities = const [], 
    this.errorData
  });

  PokemonFilterDialogState copyWith({
    bool? isLoading,
    List<FilterData>? types,
    List<FilterData>? abilities,
    ErrorData? errorData
  }) => PokemonFilterDialogState(
    isLoading: isLoading ?? this.isLoading,
    types: types ?? this.types, 
    abilities: abilities ?? this.abilities, 
    errorData: errorData
  );

  @override
  List<Object?> get props => [isLoading, types, abilities, errorData];
}