import 'dart:convert';

import 'package:http/http.dart' as http;

class PokedexService {
  static void buscandoPokemons() async {
    var response = await http.get(
      Uri.parse(
          "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );


    var json = jsonEncode(response.body);
    var jsonBody = jsonDecode(json);
  }
}
