import 'package:isar/isar.dart';

import '../../data/data.dart';

class PokemonView {

  final Id? localId;
  final int id;
  final String name;
  final String img;
  final List<String> abilities;
  final List<String> types;
  final String weightFormated;
  final String sizeFormated;

  PokemonView({
    required this.id,
    required this.name, 
    required this.img,
    this.abilities = const [],
    this.types = const [],
    this.weightFormated = '',
    this.sizeFormated = '',
    this.localId
  });
}

extension PokemonMapper on PokemonView {

  PokemonEntity mapper() => PokemonEntity(
    id: id, 
    name: name, 
    img: img,
    abilities: abilities,
    types: types,
    weightFormated: weightFormated,
    sizeFormated: sizeFormated
  );
}