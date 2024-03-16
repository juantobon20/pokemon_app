import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../helpers/service_helper.dart';

part 'pokemon_detail_screen_state.dart';

class PokemonDetailScreenCubit extends Cubit<PokemonDetailScreenState> {

  final PokemonRepository _pokemonRepository;
  PokemonDetailScreenCubit({
    required PokemonRepository pokemonRepository
  }) : _pokemonRepository = pokemonRepository, 
      super(PokemonDetailScreenState());

  void loadPokemonDetailById({
    required int pokemonId
  }) {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    ServiceHelper.handleServiceCall(
      serviceCall: () async {
        final pokemon = await _pokemonRepository.getPokemonById(id: pokemonId);
        emit(state.copyWith(
          isLoading: false,
          pokemonEntity: pokemon,
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
}
