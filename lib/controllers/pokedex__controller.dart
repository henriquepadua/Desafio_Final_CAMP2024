import 'dart:async';
import 'dart:convert';

import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PokedexService {
  Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) async {
    List<Pokemon> pokemonList = [];
    List pokemons = [];
    // ignore: prefer_typing_uninitialized_variables
    var imageUrl,type;
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$contador&limit=15'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      pokemons = jsonData['results'];

      for (var pokemonData in pokemons) {
        final name = pokemonData['name'];
        final url = pokemonData['url'];

        final responseurl = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: 1), onTimeout: () {
          throw TimeoutException('A conexão excedeu o tempo limite');
        });

        if (responseurl.statusCode == 200) {
          final jsonDataurl = jsonDecode(responseurl.body);
          final id = jsonDataurl['id'];
          final sprites = jsonDataurl['sprites'];
          final types = jsonDataurl['types'];

          for (var buscandoType in types) {
            type = buscandoType['type']['name'];
          }
          debugPrint('type $type');
          if (sprites != null) imageUrl = sprites['front_default'];

          pokemonList.add(Pokemon(
            name: name,
            id: id,
            imageUrl: imageUrl,
          ));

          debugPrint('Nome: $name, ID: $id, URL da Imagem: $imageUrl');
        }
      }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
    return pokemonList;
  }
}
