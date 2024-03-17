import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokemon_app/domain/domain.dart';
import 'package:pokemon_app/presentation/helpers/service_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  
  final PokemonRepository _pokemonRepository;

  HomeCubit({
    required PokemonRepository pokemonRepository,
  }): _pokemonRepository = pokemonRepository,
      super(const HomeState()) {
        fetchPokemonsNextPage();
      }

  void fetchPokemonsNextPage() async {
    if (state.isLoading || state.isFinishList) {
      return;
    }

    emit(state.copyWith(isLoading: true, isFilter: false));

    ServiceHelper.handleServiceCall(
      serviceCall: () async {
        final pokemons = await _pokemonRepository.getPokemons(offset: state.offset, limit: state.limit);
        emit(state.copyWith(
          isLoading: false,
          isFinishList: pokemons.isEmpty,
          offset: state.offset + 10,
          pokemons: [...state.pokemons, ...pokemons],
          errorData: null
        ));  
      }, 
      returnException: (error) {
        emit(state.copyWith(
          errorData: error,
          isLoading: false
        ));
      });
  }

  void filterPokemons(FilterData? filterData) {
    if (filterData == null || state.isLoading) {
      return;
    }

    emit(state.copyWith(
      isLoading: true,
      pokemons: []
    ));

    ServiceHelper.handleServiceCall(
      serviceCall: () async {
        final pokemons = await _pokemonRepository.getPokemonsByFilter(
          endPoint: filterData.filterType.name,
          name: filterData.name
        );
        emit(state.copyWith(
          isLoading: false,
          isFinishList: pokemons.isEmpty,
          offset: 0,
          pokemons: pokemons,
          errorData: null,
          filterData: filterData,
          isFilter: true
        ));  
      }, 
      returnException: (error) {
        emit(state.copyWith(
          errorData: error,
          isLoading: false
        ));
      });
  }

  void clearFilter() {
    emit(state.copyWith(
      isFilter: false,
      pokemons: []
    ));

    fetchPokemonsNextPage();
  }
}
