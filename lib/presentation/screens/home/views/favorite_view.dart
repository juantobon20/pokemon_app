import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/domain.dart';
import '../../../blocs/bloc.dart';
import '../../../dialogs/dialog.dart';
import '../../../widgets/widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() { 
      if ((_scrollController.position.pixels + 100) >= _scrollController.position.maxScrollExtent) {
        context.read<FavoriteViewCubit>().fetchPokemonsNextPage();
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
    context.read<FavoriteViewCubit>().fetchPokemonsNextPage();

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: BlocConsumer<FavoriteViewCubit, FavoriteViewState>(
        listener: (_, state) {
          if (state.errorData != null) {
            ErrorProvider(
              context: context, 
              errorData: state.errorData!,
              onRetryPressed: () {}
            );
          }

          setState(() {});
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if (state.pokemonsView.isNotEmpty)
                Expanded(
                  child: MasonryGridView.count(
                    controller: _scrollController,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: state.pokemonsView.length,
                    itemBuilder: (context, index) {
                      final PokemonView pokemonEntity = state.pokemonsView[index];
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