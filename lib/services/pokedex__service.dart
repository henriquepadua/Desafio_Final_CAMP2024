import 'dart:convert';

import 'package:http/http.dart' as http;

class PokedexService {
  buscandoPokemons() async {
    var response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=151"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print((jsonEncode(response.body)));
  }
}
