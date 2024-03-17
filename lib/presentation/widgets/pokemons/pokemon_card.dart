import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pokemon_app/domain/domain.dart';

class PokemonCard extends StatelessWidget {

  final PokemonView _pokemonEntity;
  final Function _onItemSelected;

  const PokemonCard({
    super.key,
    required PokemonView pokemonEntity,
    required Function onItemSelected
  }): _pokemonEntity = pokemonEntity, _onItemSelected = onItemSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onItemSelected();
      },
      child: Card(
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toBeginningOfSentenceCase(_pokemonEntity.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
          
              Container(
                alignment: Alignment.bottomRight,
                child: FadeIn(
                  child: SvgPicture.network(
                    _pokemonEntity.img,
                    height: 100,
                    width: 100,
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}