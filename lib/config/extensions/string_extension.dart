extension GetPokemonIdFromURL on String {

  int getPokemonId() {
    final path = Uri.parse(this).pathSegments;
    return int.tryParse(path[3]) ?? -1;
  }
}