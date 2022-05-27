import 'package:path/path.dart' as p;

class PokemonEntity {
  final String name;
  final String url;
  final int id;

  PokemonEntity({
    required this.name,
    required this.url,
    required this.id,
  });

  static PokemonEntity fromJson(Map<String, dynamic> json) {
    String fullUrl = json['url'];
    List<String> splittedUrl = p.split(fullUrl);
    int jsonId = int.parse(splittedUrl[5]);

    return PokemonEntity(
      name: json['name'] as String,
      url: json['url'] as String,
      id: jsonId.toInt(),
    );
  }
}
