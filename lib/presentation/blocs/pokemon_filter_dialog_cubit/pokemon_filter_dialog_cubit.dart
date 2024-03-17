import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/presentation/helpers/service_helper.dart';

import '../../../../domain/domain.dart';

part 'pokemon_filter_dialog_state.dart';

class PokemonFilterDialogCubit extends Cubit<PokemonFilterDialogState> {

  final PokemonRepository _pokemonRepository;
  PokemonFilterDialogCubit({
    required PokemonRepository pokemonRepository
  }) : _pokemonRepository = pokemonRepository,
   super(const PokemonFilterDialogState());

  void loadFilters(FilterData? filterData) async {
    emit(state.copyWith(isLoading: true));

    ServiceHelper.handleServiceCall(
      serviceCall: () async {

        final typeFilters = await _pokemonRepository.getFilters(endPoint: "type");
        final abilitiesFilters = await _pokemonRepository.getFilters(endPoint: "ability");

        emit(state.copyWith(
          isLoading: false,
          types: typeFilters,
          abilities: abilitiesFilters,
          errorData: null
        ));  

        if (filterData != null) {
          selectedItem(filterData);
        }
      }, 
      returnException: (error) {
        emit(state.copyWith(
          errorData: error,
          isLoading: false
        ));
      });
  }

  void selectedItem(FilterData filterData) {
    List<FilterData> types;
    List<FilterData> abilities;

    switch (filterData.filterType) {
      case FilterType.type :
        types = state.types.map((type) => type.copyWith(isChecked: type.name == filterData.name)).toList();
        abilities = state.abilities.map((ability) => ability.copyWith(isChecked: false)).toList();
        break;
      case FilterType.ability :
        types = state.types.map((type) => type.copyWith(isChecked: false)).toList();
        abilities = state.abilities.map((ability) => ability.copyWith(isChecked: ability.name == filterData.name)).toList();
        break;
    }

    emit(state.copyWith(
      types: types,
      abilities: abilities
    ));
  }

  FilterData? filterSelected() {
    FilterData? filterData;
    List allFilter = state.types + state.abilities;
    for (var element in allFilter) {
      if (element.isChecked) {
        filterData = element;
      }
    }

    return filterData;
  }
}
