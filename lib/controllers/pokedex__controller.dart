import 'dart:convert';

import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class PokedexService {
  Future<List<Pokemon>> buscandoDadosDosPokemons(int contador) async {
    List<Pokemon> pokemonList = [];
    List pokemons = [];
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=$contador&limit=15'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      pokemons = jsonData['results'];

      for (var pokemonData in pokemons) {
        final name = pokemonData['name'];
        final url = pokemonData['url'];
        final responseurl = await http.get(Uri.parse(pokemonData['url']));

        if (responseurl.statusCode == 200) {
          final jsonDataurl = jsonDecode(responseurl.body);
          final id = jsonDataurl['id'];
          final sprites = jsonDataurl['sprites'];
          final imageUrl = sprites['front_shiny'];

          pokemonList.add(Pokemon(
            name: name,
            id: id,
            imageUrl: imageUrl,
          ));

          print('Nome: $name, ID: $id, URL da Imagem: $imageUrl');
        }
      }
    } else {
      throw Exception('Não Encontrei nenhum pokemon');
    }
    return pokemonList;
  }
}
