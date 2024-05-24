import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Desafio_Final_CAMP2024/controllers/pokedex__controller.dart';
import 'package:Desafio_Final_CAMP2024/models/Pokemon_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:retry/retry.dart';

void main() {
  group('PokedexController', () {
    late PokedexController pokedexController;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      pokedexController = PokedexController(dio: dio);
    });

    test(
        'buscandoDadosDosPokemons retorna uma lista de Pokemons quando a resposta é bem-sucedida',
        () async {
      final mockPokemonList = {
        "results": [
          {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
          {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"}
        ]
      };

      final mockPokemonData1 = {
        "id": 1,
        "sprites": {
          "front_default":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        },
        "types": [
          {
            "type": {"name": "grass"}
          }
        ]
      };

      final mockPokemonData2 = {
        "id": 2,
        "sprites": {
          "front_default":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"
        },
        "types": [
          {
            "type": {"name": "grass"}
          }
        ]
      };

      dioAdapter.onGet(
        'https://pokeapi.co/api/v2/pokemon?offset=0&limit=15',
        (request) {
          return request.reply(200, mockPokemonList);
        },
      );

      dioAdapter.onGet(
        'https://pokeapi.co/api/v2/pokemon/1/',
        (request) {
          return request.reply(200, mockPokemonData1);
        },
      );

      dioAdapter.onGet(
        'https://pokeapi.co/api/v2/pokemon/2/',
        (request) {
          return request.reply(200, mockPokemonData2);
        },
      );

      final pokemonList = await pokedexController.buscandoDadosDosPokemons(0);

      expect(pokemonList, isA<List<Pokemon>>());
      expect(pokemonList.length, 2);
      expect(pokemonList[0].name, 'bulbasaur');
      expect(pokemonList[1].name, 'ivysaur');
    });

    test(
        'buscandoDadosDosPokemons lança uma exceção quando a resposta da API falha',
        () async {
      dioAdapter.onGet(
        'https://pokeapi.co/api/v2/pokemon?offset=0&limit=15',
        (request) {
          return request.reply(404, 'Not Found');
        },
      );

      expect(
        () async => await pokedexController.buscandoDadosDosPokemons(0),
        throwsException,
      );
    });

    // test(
    //     'buscandoDadosDosPokemons tenta novamente quando há uma falha temporária na rede',
    //     () async {
    //   int retryCount = 0;

    //   dioAdapter.onGet(
    //     'https://pokeapi.co/api/v2/pokemon?offset=0&limit=15',
    //     (request) {
    //       if (retryCount < 2) {
    //         retryCount++;
    //         return request.throws(
    //           DioError(
    //               requestOptions: RequestOptions(path: ''),
    //               error: DioErrorType.response,
    //               response: Response(
    //                 statusCode: 500,
    //                 statusMessage: 'Internal Server Error',
    //                 requestOptions: RequestOptions(path: ''),
    //               )) as int,
    //         );
    //       } else {
    //         final mockPokemonList = {
    //           "results": [
    //             {
    //               "name": "bulbasaur",
    //               "url": "https://pokeapi.co/api/v2/pokemon/1/"
    //             }
    //           ]
    //         };
    //         return request.reply(200, mockPokemonList);
    //       }
    //     },
    //   );

    //   final mockPokemonData1 = {
    //     "id": 1,
    //     "sprites": {
    //       "front_default":
    //           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
    //     },
    //     "types": [
    //       {
    //         "type": {"name": "grass"}
    //       }
    //     ]
    //   };

    //   dioAdapter.onGet(
    //     'https://pokeapi.co/api/v2/pokemon/1/',
    //     (request) {
    //       return request.reply(200, mockPokemonData1);
    //     },
    //   );

    //   final pokemonList = await pokedexController.buscandoDadosDosPokemons(0);

    //   expect(pokemonList, isA<List<Pokemon>>());
    //   expect(pokemonList.length, 1);
    //   expect(pokemonList[0].name, 'bulbasaur');
    //   expect(retryCount, 2); // Verifica se houve 2 tentativas antes do sucesso
    // });
  });
}
