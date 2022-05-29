class HttpClientBase {
  final String _baseUrl = 'https://pokeapi.co/api/v2/';

  static const String basePokemonSpritesUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/';

  static const String basePokemonOficialArtWorkUrl =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/';

  final String route;

  HttpClientBase(
    this.route,
  );

  Uri httpClient() {
    final uri = Uri.parse(_baseUrl + route);
    return uri;
  }
}
