import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pokemon_app/presentation/widgets/widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 16
      ),
      child: MasonryGridView.count(
        crossAxisCount: 2, 
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: 10,
        itemBuilder:(context, index) {
          if (index == 1) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  PokemonCard(onItemSelected: () {
                    print('Name: Pokemon');
                  },)
                ],
              );
            }
            return PokemonCard(onItemSelected: () {
              print('Name: Pokemon');
            });
        },
      ),
    );
  }
}