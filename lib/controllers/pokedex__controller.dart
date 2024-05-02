import 'dart:convert';

import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PokedexService {
  Future<void> buscandoDadosDosPokemons() async {
    List pokemonList = [];
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=150'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> pokemonNames = [];
      pokemonList = jsonData['results'];

      for (var pokemon in pokemonList) {//pega todos os nomes
        pokemonNames.add(pokemon['name']);//adiciona os nomes em uma lista
        print(pokemon['name']);
      //   for (var url in pokemonList) {//pega todoas url
      //   final responseurl = await http.get(Uri.parse(url['url']));

      //   if (responseurl.statusCode == 200) {
      //     final jsonDataurl = jsonDecode(responseurl.body);
      //     final sprites = jsonDataurl['sprites'];

      //     if (sprites != null) {
      //       print(pokemon['name']);
      //       print(jsonDataurl['id']);
      //       print(sprites['front_shiny']);
      //     }
      //   }
      // }
      }

      // for (var url in pokemonList) {
      //   final responseurl = await http.get(Uri.parse(url['url']));

      //   if (responseurl.statusCode == 200) {
      //     final jsonDataurl = jsonDecode(responseurl.body);
      //     final sprites = jsonDataurl['sprites'];

      //     if (sprites != null) {
      //       print(jsonDataurl['id']);
      //       print(sprites['front_shiny']);
      //     }
      //   }
      // }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
  }
}
