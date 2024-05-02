import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:desafio_final_camp2024/controllers/pokedex__controller.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  TextEditingController pokemonController = TextEditingController();
  List pokemonList = []; // Lista de Pokémon
  List urlList = [];

  void initState() {
    super.initState();
    PokedexService().buscandoDadosDosPokemons();
  }

  // Future<void> buscandoDadosDosPokemons() async {
  //   final response = await http
  //       .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=150'));

  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     List<String> pokemonNames = [];
  //     pokemonList = jsonData['results'];

  //     for (var pokemon in pokemonList) {
  //       pokemonNames.add(pokemon['name']);
  //     }

  //     for (var url in pokemonList) {
  //       final responseurl = await http.get(Uri.parse(url['url']));

  //       if (responseurl.statusCode == 200) {
  //         final jsonDataurl = jsonDecode(responseurl.body);
  //         final sprites = jsonDataurl['sprites'];

  //         if (sprites != null) {
  //           print(jsonDataurl['id']);
  //           print(sprites['front_shiny']);
  //         }
  //       }
  //     }
  //   } else {
  //     throw Exception('Não Encontrei nenhum pokemon');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.asset("assets/Rectangle15.png"),
            Column(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    Image.asset("assets/Group17.png"),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25)),
                    Image.asset("assets/Switch.png")
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                        child: TextField(
                          controller: pokemonController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            suffixIconColor: Color.fromRGBO(236, 3, 68, 1),
                            hintText: "Buscar pokemon",
                            labelText: "Buscar",
                            labelStyle: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(236, 3, 68, 1)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(236, 3, 68, 1),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: Color.fromRGBO(236, 3, 68, 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                        child: Image.asset("assets/heart.png")),
                  ],
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 1.4),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text("#001"),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
