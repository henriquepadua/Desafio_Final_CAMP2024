import 'dart:async';
import 'dart:convert';

import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
import 'package:desafio_final_camp2024/setting.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../models/Pokemon_model.dart';

class PokedexService {
  Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) async {
    List<Pokemon> pokemonList = [];
    List pokemons = [];
    // ignore: prefer_typing_uninitialized_variables
    var imageUrl, type, cor;
    int primeiraCor = 0, segundaCor = 0, terceiraCor = 0;
    double quartaCor = 0;
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

          // for (var buscandoType in types) {
          //   type = buscandoType['type']['name'];
          // }

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
          debugPrint('type $type');
          if (sprites != null) imageUrl = sprites['front_default'];

          pokemonList.add(Pokemon(
              name: name,
              id: id,
              imageUrl: imageUrl,
              primeiroValorCor: primeiraCor,
              segundoValorCor: segundaCor,
              terceiroValorCor: terceiraCor,
              quartoValorCor: quartaCor
              // Adicione a cor ao objeto Pokemon
              ));
          // pokemonList.add(Pokemon(
          //   name: name,
          //   id: id,
          //   imageUrl: imageUrl,
          // ));

          debugPrint('Nome: $name, ID: $id, URL da Imagem: $imageUrl cor $cor');
        }
      }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
    return pokemonList;
  }

  // Future<List<Pokemon>> buscandoPokemonsPeloNome(
  //     int contador, String nomeDigitado) async {
  //   List<Pokemon> pokemonList = [];
  //   List pokemons = [];
  //   // ignore: prefer_typing_uninitialized_variables
  //   var imageUrl, type;
  //   final response = await http
  //       .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=150'));

  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     pokemons = jsonData['results'];

  //     for (var pokemonData in pokemons) {
  //       final name = pokemonData['name'];
  //       final url = pokemonData['url'];

  //       final responseurl = await http
  //           .get(Uri.parse(url))
  //           .timeout(const Duration(seconds: 1), onTimeout: () {
  //         throw TimeoutException('A conexão excedeu o tempo limite');
  //       });

  //       if (responseurl.statusCode == 200) {
  //         final jsonDataurl = jsonDecode(responseurl.body);
  //         final id = jsonDataurl['id'];
  //         final sprites = jsonDataurl['sprites'];
  //         final types = jsonDataurl['types'];

  //         for (var buscandoType in types) {
  //           type = buscandoType['type']['name'];
  //         }
  //         debugPrint('type $type');
  //         if (sprites != null) imageUrl = sprites['front_default'];

  //         if (name == nomeDigitado) {
  //           pokemonList.add(Pokemon(
  //             name: name,
  //             id: id,
  //             imageUrl: imageUrl,
  //           ));
  //           break;
  //         }

  //         debugPrint('Nome: $name, ID: $id, URL da Imagem: $imageUrl');
  //       }
  //     }
  //   } else {
  //     throw Exception('Não Encontrei nenhum pokemon');
  //   }
  //   return pokemonList;
  // }
}
