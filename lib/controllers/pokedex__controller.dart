import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
import 'package:desafio_final_camp2024/setting.dart';

class PokedexController {
  Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) async {
    List<Pokemon> pokemonList = [];
    dynamic cor;

    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$contador&limit=15'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List pokemons = jsonData['results'];

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

          dynamic type;
          double quartaCor = 0;
          int primeiraCor = 0, segundaCor = 0, terceiraCor = 0;

          for (var buscandoType in types) {
            type = buscandoType['type']['name'];
            // Encontre a cor correspondente ao tipo
            final List<Map<String, String>> cores = PokemonTipo.getCores();
            cor =
                cores.firstWhere((element) => element['type'] == type)['color'];
            // Adicione a cor ao objeto Pokemon
            var numeros = cor.split(',');
            primeiraCor = int.parse(numeros[0]);
            segundaCor = int.parse(numeros[1]);
            terceiraCor = int.parse(numeros[2]);
            quartaCor = double.parse(numeros[3]);
            break;
          }

          dynamic imageUrl;
          if (sprites != null) imageUrl = sprites['front_default'];

          pokemonList.add(Pokemon(
              name: name,
              id: id,
              imageUrl: imageUrl,
              primeiroValorCor: primeiraCor,
              segundoValorCor: segundaCor,
              terceiroValorCor: terceiraCor,
              quartoValorCor: quartaCor));

          debugPrint(
              'Nome: $name, ID: $id, URL da Imagem: $imageUrl cor $type');
        }
      }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
    return pokemonList;
  }
}
