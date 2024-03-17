extension GetPokemonIdFromURL on String {

  int getPokemonId() {
    final path = Uri.parse(this).pathSegments;
    return int.tryParse(path[3]) ?? -1;
  }
}

extension GetImageUrl on int {

  String getImageUrl() {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$this.svg';
  }
}