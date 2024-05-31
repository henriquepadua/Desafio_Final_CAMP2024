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
      () => dio
          .get('https://pokeapi.co/api/v2/pokemon?offset=$contador&limit=15'),
      retryIf: (e) => e is DioError || e is TimeoutException,
    );

    if (response.statusCode == 200) {
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
          final jsonDataurl = responseurl.data as Map<String, dynamic>;
          final id = jsonDataurl['id'];
          final sprites = jsonDataurl['sprites'];
          final types = jsonDataurl['types'];
          final abilities = jsonDataurl['abilities'];
          final weight = (jsonDataurl['weight']) / 10;
          final height = jsonDataurl['height'] / 10;
          final stats = jsonDataurl['stats'];

          dynamic type, primeiraAbilitie, atk, def, satk, sdef, spo, hp;
          double quartaCor = 0;
          int primeiraCor = 0,
              segundaCor = 0,
              terceiraCor = 0,
              contador = 0,
              contadorStat = 0;

          for (var buscandoStat in stats) {
            if (contadorStat == 0) {
              hp = buscandoStat['base_stat'];
            } else if (contadorStat == 1) {
              atk = buscandoStat['base_stat'];
            } else if (contadorStat == 2) {
              def = buscandoStat['base_stat'];
            } else if (contadorStat == 3) {
              satk = buscandoStat['base_stat'];
            } else if (contadorStat == 4) {
              sdef = buscandoStat['base_stat'];
            } else if (contadorStat == 5) {
              spo = buscandoStat['base_stat'];
            }
            contadorStat++;
          }

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

          for (var buscandoType in abilities) {
            if (contador == 0)
              primeiraAbilitie = buscandoType['ability']['name'] + " / ";
            if (contador == 1)
              primeiraAbilitie += buscandoType['ability']['name'];
            contador++;
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
            quartoValorCor: quartaCor,
            moves: primeiraAbilitie,
            weight: weight,
            height: height,
            atk: atk,
            def: def,
            satk: satk,
            sdef: sdef,
            spo: spo,
            hp: hp,
          ));

          debugPrint(
              'Nome: $name, ID: $id, URL da Imagem: $imageUrl cor $type moves $primeiraAbilitie');
        }
      }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
    return pokemonList;
  }
}
