
import 'package:isar/isar.dart';
import 'package:pokemon_app/domain/entities/pokemon_view.dart';

part 'pokemon_entity.g.dart';

@collection
class PokemonEntity {
  Id uId = Isar.autoIncrement;
  final int id;
  final String name;
  final String img;
  final List<String> abilities;
  final List<String> types;
  final String weightFormated;
  final String sizeFormated;

  PokemonEntity({
    required this.id,
    required this.name, 
    required this.img,
    this.abilities = const [],
    this.types = const [],
    this.weightFormated = '',
    this.sizeFormated = ''
  });
}

extension PokemonEntityMapper on PokemonEntity {

  PokemonView mapper() => PokemonView(
    localId: uId,
    id: id, 
    name: name, 
    img: img,
    abilities: abilities,
    types: types,
    weightFormated: weightFormated,
    sizeFormated: sizeFormated
  );
}