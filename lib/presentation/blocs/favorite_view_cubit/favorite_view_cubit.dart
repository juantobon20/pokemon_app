import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/domain.dart';

part 'favorite_view_state.dart';

class FavoriteViewCubit extends Cubit<FavoriteViewState> {

  final isFavoriteController = StreamController<bool>.broadcast();
  Stream<bool> get isFavorite => isFavoriteController.stream;

  final PokemonRepository _pokemonRepository;
  FavoriteViewCubit({
    required PokemonRepository pokemonRepository
  }) : _pokemonRepository = pokemonRepository, 
  super(FavoriteViewInitial()) {
    fetchPokemonsNextPage();
  }

  void fetchPokemonsNextPage() async {
    if (state.isLoading || state.isFinishList) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final favoritesPokemons = await _pokemonRepository.loadFavoritesPokemons(offset: state.offset, limit: state.limit);
      emit(state.copyWith(
          isLoading: false,
          isFinishList: favoritesPokemons.isEmpty,
          offset: state.offset + 10,
          pokemonsView: [...state.pokemonsView, ...favoritesPokemons],
          errorData: null
        ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorData: ErrorData(
          errorType: ErrorType.otherError,
          errorMessage: 'Error al obtener listado de favoritos',
          errorTitle: 'Error favoritos'
        )
      ));
    }
  }

  Future<void> toggleFavorite(PokemonView pokemonView) async {
    await _pokemonRepository.toggleFavorite(pokemonView);

    isFavoritePokemon(pokemonView.id);

    for (var pokemon in state.pokemonsView) {
      if (pokemon.id == pokemonView.id) {
        final newList = state.pokemonsView;
        newList.remove(pokemon);

        emit(state.copyWith(
          pokemonsView: newList
        ));
        return;
      }
    }
    
    emit(state.copyWith(
        pokemonsView: [...state.pokemonsView, pokemonView]
    ));
  }

  void isFavoritePokemon(int pokemonId) async {
    isFavoriteController.sink.add(await _pokemonRepository.isPokemonFavorite(pokemonId));
  }

  
}
