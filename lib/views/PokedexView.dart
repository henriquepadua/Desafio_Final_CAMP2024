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
    PokedexService().buscandoDadosDosPokemons(10);
  }

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
                  itemCount: 39,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text("#001",textAlign:TextAlign.end),
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
