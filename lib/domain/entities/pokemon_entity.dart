class PokemonEntity {

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
    required this.abilities,
    required this.types,
    required this.weightFormated,
    required this.sizeFormated
  });
}