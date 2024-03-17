import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/domain/domain.dart';

import '../../../blocs/bloc.dart';
import '../../../dialogs/dialog.dart';
import '../../../widgets/widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() { 
      if ((_scrollController.position.pixels + 100) >= _scrollController.position.maxScrollExtent) {
        context.read<HomeCubit>().fetchPokemonsNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (_, state) {
          if (state.errorData != null) {
            ErrorProvider(
              context: context, 
              errorData: state.errorData!,
              onRetryPressed: context.read<HomeCubit>().fetchPokemonsNextPage
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (state.pokemons.isNotEmpty)
                FadeIn(
                  child: PrimaryButton(
                    icon: const Icon(Icons.filter_alt_sharp),
                    text: 'Filtros', 
                    onPressedCallback: () {
                      showPokemonFilterDialog(
                        context: context, 
                        isFilter: state.isFilter,
                        filterData: state.filterData,
                        returnFilter: context.read<HomeCubit>().filterPokemons,
                        clearFilter: context.read<HomeCubit>().clearFilter
                      );
                    }
                  ),
                ),

              if (state.pokemons.isNotEmpty)
                Expanded(
                  child: MasonryGridView.count(
                    controller: _scrollController,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: state.pokemons.length,
                    itemBuilder: (context, index) {
                      final PokemonView pokemonEntity = state.pokemons[index];
                      return FadeIn(
                        child: Column(
                          children: [
                            if (index == 1)
                              const SizedBox(height: 20),

                            PokemonCard(
                              pokemonEntity: pokemonEntity,
                              onItemSelected: () {
                                context.push('/home/pokemon_detail/${pokemonEntity.id}');
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

              if (state.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Center(child: LoadingDialog()),
                )
            ],
          );
        },
      )
    );
  }
}
