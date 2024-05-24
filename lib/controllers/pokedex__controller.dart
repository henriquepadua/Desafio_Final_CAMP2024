import 'dart:async';
import 'dart:convert';
import 'package:Desafio_Final_CAMP2024/models/Pokemon_model.dart';
import 'package:Desafio_Final_CAMP2024/setting.dart';
import 'package:retry/retry.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PokedexController {
  final Dio dio;

  PokedexController({required this.dio});

  Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) async {
    List<Pokemon> pokemonList = [];
    dynamic cor;
    const r = RetryOptions(maxAttempts: 3);

    final response = await r.retry(
      () => dio.get('https://pokeapi.co/api/v2/pokemon?offset=$contador&limit=15'),
      retryIf: (e) => e is DioError || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      //final jsonData = jsonDecode(response.data);
      final jsonData = response.data as Map<String, dynamic>;
      List pokemons = jsonData['results'];

      for (var pokemonData in pokemons) {
        final name = pokemonData['name'];
        final url = pokemonData['url'];

        final responseurl = await r.retry(
          () => dio.get(url).timeout(const Duration(seconds: 1)),
          retryIf: (e) => e is DioError || e is TimeoutException,
        );

        if (responseurl.statusCode == 200) {
          //final jsonDataurl = jsonDecode(responseurl.data);
          final jsonDataurl = responseurl.data as Map<String, dynamic>;
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
            cor = cores.firstWhere((element) => element['type'] == type)['color'];
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

          debugPrint('Nome: $name, ID: $id, URL da Imagem: $imageUrl cor $type');
        }
      }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
    return pokemonList;
  }
}


// import 'dart:async';
// import 'dart:convert';
// import 'package:retry/retry.dart';
// import 'package:Desafio_Final_CAMP2024/models/Pokemon_model.dart';
// import 'package:Desafio_Final_CAMP2024/setting.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class PokedexController {
//   Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) async {
//     List<Pokemon> pokemonList = [];
//     dynamic cor;
//     const r = RetryOptions(maxAttempts: 3);

//     final response = await r.retry(
//       () => http.get(Uri.parse(
//           'https://pokeapi.co/api/v2/pokemon?offset=$contador&limit=15')),
//       retryIf: (e) => e is http.ClientException || e is TimeoutException,
//     );

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       List pokemons = jsonData['results'];

//       for (var pokemonData in pokemons) {
//         final name = pokemonData['name'];
//         final url = pokemonData['url'];

//         final responseurl = await r.retry(
//           () => http.get(Uri.parse(url)).timeout(const Duration(seconds: 1)),
//           retryIf: (e) => e is http.ClientException || e is TimeoutException,
//         );

//         if (responseurl.statusCode == 200) {
//           final jsonDataurl = jsonDecode(responseurl.body);
//           final id = jsonDataurl['id'];
//           final sprites = jsonDataurl['sprites'];
//           final types = jsonDataurl['types'];

//           dynamic type;
//           double quartaCor = 0;
//           int primeiraCor = 0, segundaCor = 0, terceiraCor = 0;

//           for (var buscandoType in types) {
//             type = buscandoType['type']['name'];
//             // Encontre a cor correspondente ao tipo
//             final List<Map<String, String>> cores = PokemonTipo.getCores();
//             cor =
//                 cores.firstWhere((element) => element['type'] == type)['color'];
//             // Adicione a cor ao objeto Pokemon
//             var numeros = cor.split(',');
//             primeiraCor = int.parse(numeros[0]);
//             segundaCor = int.parse(numeros[1]);
//             terceiraCor = int.parse(numeros[2]);
//             quartaCor = double.parse(numeros[3]);
//             break;
//           }

//           dynamic imageUrl;
//           if (sprites != null) imageUrl = sprites['front_default'];

//           pokemonList.add(Pokemon(
//               name: name,
//               id: id,
//               imageUrl: imageUrl,
//               primeiroValorCor: primeiraCor,
//               segundoValorCor: segundaCor,
//               terceiroValorCor: terceiraCor,
//               quartoValorCor: quartaCor));

//           debugPrint(
//               'Nome: $name, ID: $id, URL da Imagem: $imageUrl cor $type');
//         }
//       }
//     } else {
//       throw Exception('Não Encontrei nenhum pokemon');
//     }
//     return pokemonList;
//   }
// }