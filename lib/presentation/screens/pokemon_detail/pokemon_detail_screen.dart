import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_app/domain/domain.dart';

import '../../blocs/bloc.dart';
import '../../dialogs/dialog.dart';
import '../../widgets/widget.dart';

class PokemonDetailScreen extends StatelessWidget {
  final int pokemonId;
  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {

    context.read<PokemonDetailScreenCubit>().loadPokemonDetailById(pokemonId: pokemonId);

    return Scaffold(
      body: BlocConsumer<PokemonDetailScreenCubit, PokemonDetailScreenState>(
        listener: (_, state) {
          if (state.errorData != null) {
            ErrorProvider(
              context: context, 
              errorData: state.errorData!,
              onRetryPressed: () => context.read<PokemonDetailScreenCubit>().loadPokemonDetailById(pokemonId: pokemonId)
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: LoadingDialog());
          }

          if (state.pokemonView != null) {
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _CustomSliverAppBar(
                  pokemonView: state.pokemonView!,
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _PokemonDetail(
                      pokemonEntity: state.pokemonView!,
                    ),
                    childCount: 1
                  )
                )
              ],
            );
          }

          return const Placeholder();
        }
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final PokemonView pokemonView;

  const _CustomSliverAppBar({
    required this.pokemonView
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<FavoriteViewCubit>().isFavoritePokemon(pokemonView.id);

    return SliverAppBar(
      backgroundColor: Colors.amber,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            context.read<FavoriteViewCubit>().toggleFavorite(pokemonView);
          },
          icon: StreamBuilder<bool>(
            initialData: false,
            stream: BlocProvider.of<FavoriteViewCubit>(context).isFavorite,
            builder: (context, snapshot) => 
              (snapshot.data ?? false)
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border),
          ),
        //icon: const Icon(Icons.favorite_border)
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 24),
        title: Text(
          pokemonView.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        background: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox.expand(
                child: SvgPicture.network(
                  pokemonView.img,
                  height: 150,
                  width: 150,
                )
              ),
            ),

            const CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.amber, Colors.transparent]
            ),

            const CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0,0.2],
              colors: [Colors.amber, Colors.transparent]
            ),

            const CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.85, 1.0],
              colors: [Colors.transparent, Colors.amber]),
          ],
        ),
      ),
    );
  }
}

class _PokemonDetail extends StatelessWidget {
  final PokemonView pokemonEntity;

  const _PokemonDetail({
    required this.pokemonEntity
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AbilitiesAndTypes(
              title: 'Habilidades',
              list: pokemonEntity.abilities,
            ),

            const SizedBox(height: 16),

            _Size(
              weight: pokemonEntity.weightFormated,
              size: pokemonEntity.sizeFormated,
            ),

            const SizedBox(height: 16),

            _AbilitiesAndTypes(
              title: "Tipos",
              list: pokemonEntity.types,
            ),
          ],
        ),
      ),
    );
  }
}

class _AbilitiesAndTypes extends StatelessWidget {

  final String title;
  final List<String> list;

  const _AbilitiesAndTypes({
    required this.title,
    required this.list
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: const BorderRadius.all(Radius.circular(16))
                    ),
                    child: Text(list[index]),
                  ),
                  const SizedBox(width: 8)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Size extends StatelessWidget {

  final String weight;
  final String size;

  const _Size({
    required this.weight,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/weight.png',
            width: 50,
            height: 50,
          ),

          const SizedBox(width: 8),

          Text(weight),

          const Spacer(),

          Image.asset(
            'assets/images/size.png',
            width: 50,
            height: 50,
          ),

          Text(size),

          const Spacer(),
        ],
      ),
    );
  }
}
