import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/core/network/http_client_base.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:string_extensions/string_extensions.dart';

class PokemonEntity {
  String? name;
  String? url;
  int? id;

  PokemonEntity({
    this.name,
    this.url,
    this.id,
  });

  PokemonEntity.fromJson(Map<String, dynamic> json) {
    String fullUrl = json['url'];
    List<String> splittedUrl = p.split(fullUrl);
    int jsonId = int.parse(splittedUrl[5]);
    name = json['name'].toString().capitalize;
    url = json['url'];
    id = jsonId;
  }
}

class CoreGateway {
  static Future<List<PokemonEntity>> getPokemonList() async {
    const String pokemonListRoute = "pokemon?limit=901&offset=0";
    final pokemonListUri = HttpClientBase(pokemonListRoute).httpClient();
    http.Response response = await http.get(pokemonListUri);
    if (response.statusCode == 200) {
      final pokemonList = json.decode(response.body);
      var resultado2 = pokemonList['results'] as List;
      return resultado2.map<PokemonEntity>((json) => PokemonEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class CoreController {
  static late ValueNotifier<List<PokemonEntity>> pokemonList = ValueNotifier([]);

  void initialize() {}

  static void getPokemonList() async {
    List<PokemonEntity> result = await CoreGateway.getPokemonList();
    pokemonList.value = result;
  }
}
