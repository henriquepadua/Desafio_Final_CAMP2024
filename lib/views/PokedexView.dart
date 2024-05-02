import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:desafio_final_camp2024/controllers/pokedex__controller.dart';

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  TextEditingController pokemonController = TextEditingController();
  late Future<List<Pokemon>> pokemonList; // Lista de Pokémon

  @override
  void initState() {
    super.initState();
    pokemonList = PokedexService().buscandoDadosDosPokemons(0);
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
                          style: const TextStyle(
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,20,0,5),
                child: FutureBuilder<List<Pokemon>>(
                  future: pokemonList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Enquanto o Future estiver esperando, exibir um indicador de carregamento
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Se ocorrer um erro durante a busca dos dados, exiba uma mensagem de erro
                      return const Center(child: Text('Erro ao carregar dados'));
                    } else {
                      // Se os dados forem carregados com sucesso, construa o GridView
                      final pokemonList =
                          snapshot.data ?? []; // Obtenha a lista de pokemons
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5),
                        itemCount: pokemonList
                            .length, // Usar o comprimento da lista de pokemons
                        itemBuilder: (context, index) {
                          final pokemon = pokemonList[index];
                          return Card(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("#${pokemon.id}",
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(color: Colors.blue),    
                                    ),
                                  ],
                                ),
                                Image.network(
                                  width: 60,
                                  pokemon.imageUrl,
                                ),
                                Text("${pokemon.name}",
                                    textAlign: TextAlign.end),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),

            // Expanded(
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3, childAspectRatio: 1.4),
            //     itemCount: 15,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Column(
            //           children: [
            //             Text("#001", textAlign: TextAlign.end),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
