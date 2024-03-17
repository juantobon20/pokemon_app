import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../../blocs/bloc.dart';
import '../../widgets/widget.dart';
import '../dialog.dart';

void showPokemonFilterDialog({
  required BuildContext context,
  required bool isFilter,
  FilterData? filterData,
  required void Function(FilterData? filterData) returnFilter,
  required void Function() clearFilter
}) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) => BlocProvider(
        create: (context) => PokemonFilterDialogCubit(
          pokemonRepository: PokemonRepositoryImpl(
            pokemonDatasource: PokemonDatasourceImpl()
          )
        ),
        child: _PokemonFilterDialog(
          isFilter: isFilter,
          filterData: filterData,
          returnFilter: returnFilter,
          clearFilter: clearFilter,
        ),
      ));
}

class _PokemonFilterDialog extends StatelessWidget {

  final bool isFilter;
  final FilterData? filterData;
  final Function(FilterData? filterData) returnFilter;
  final Function() clearFilter;

  const _PokemonFilterDialog({
    required this.isFilter,
    required this.filterData,
    required this.returnFilter,
    required this.clearFilter
  });

  @override
  Widget build(BuildContext context) {
    context.read<PokemonFilterDialogCubit>().loadFilters(filterData);

    return BlocConsumer<PokemonFilterDialogCubit, PokemonFilterDialogState>(
      listener: (context, state) {
        if (state.errorData != null) {
            ErrorProvider(
              context: context, 
              errorData: state.errorData!,
              onRetryPressed: context.read<PokemonFilterDialogCubit>().loadFilters
            );
          }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingDialog();
        }
        
        return _PokemonFilter(
          isFilter: isFilter,
          types: state.types,
          abilities: state.abilities,
          returnFilter: returnFilter,
          clearFilter: clearFilter,
        ); 
      }
    );
  }
}

class _PokemonFilter extends StatelessWidget {

  final bool isFilter;
  final List<FilterData> types;
  final List<FilterData> abilities;
  final Function(FilterData? filterData) returnFilter;
  final Function() clearFilter;

  const _PokemonFilter({
    required this.isFilter,
    required this.types, 
    required this.abilities, 
    required this.returnFilter,
    required this.clearFilter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                const Text(
                  'Filtros',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.close_sharp,
                      color: Colors.red,
                    ))
              ],
            ),
            _FilterOptions(
              title: 'Tipo',
              filters: types,
            ),
            _FilterOptions(
              title: 'Habilidades',
              filters: abilities,
            ),

            const SizedBox(height: 16),

            PrimaryButton(
              text: 'Filtrar', 
              onPressedCallback: () {
                context.pop();
                returnFilter(context.read<PokemonFilterDialogCubit>().filterSelected());
              }
            ),

            if (isFilter)
              SecondaryButton(
                text: 'Limpiar filtro', 
                onPressedCallback: () {
                  context.pop();
                  clearFilter();
                }
              )
          ],
        ),
      ),
    );
  }
}

class _FilterOptions extends StatelessWidget {
  final String title;
  final List<FilterData> filters;
  const _FilterOptions({required this.title, required this.filters});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Divider(height: 2),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 10,
        alignment: WrapAlignment.start,
        children: [
          ...filters.map((filterData) {
            final BoxDecoration boxDecoration = filterData.isChecked
                ? BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(16)))
                : const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)));
            return GestureDetector(
              onTap: () => context.read<PokemonFilterDialogCubit>().selectedItem(filterData),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: boxDecoration,
                child: Text(toBeginningOfSentenceCase(filterData.name)),
              ),
            );
          })
        ],
      ),
      const SizedBox(height: 8),
    ]);
  }
}
