class HttpClientBase {
  final String _baseUrl = 'https://pokeapi.co/api/v2/';
  final String route;

  HttpClientBase(
    this.route,
  );

  Uri httpClient() {
    final uri = Uri.parse(_baseUrl + route);
    return uri;
  }
}
