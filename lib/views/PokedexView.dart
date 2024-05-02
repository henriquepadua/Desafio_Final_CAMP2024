import 'package:desafio_final_camp2024/models/Pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:desafio_final_camp2024/controllers/pokedex__controller.dart';

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  TextEditingController pokemonController = TextEditingController();
  late Future<List<Pokemon>> pokemonLista; // Lista de Pokémon
  int contador = 0;

  @override
  void initState() {
    super.initState();
    pokemonLista = PokedexService().buscandoDadosDosPokemons(contador);
  }

  Future<void> carregarMaisPokemons() async {
    contador += 15; // Incrementa o contador

    try {
      final bucandoMaisPokemons =
          await PokedexService().buscandoDadosDosPokemons(contador);

      final listaAtualPokemon = await pokemonLista;
      final atualizaListaPokemonNaTela = List<Pokemon>.from(listaAtualPokemon)
        ..addAll(bucandoMaisPokemons);
      setState(() {
        pokemonLista =
            Future.value(atualizaListaPokemonNaTela); //Atualizo os dados
      });
    } catch (e) {
      contador -= 15; //Sempre volto 15 caso a chamada na api de exceção
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar mais pokemons: $e'),
        ),
      );
    }
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
                padding: const EdgeInsets.fromLTRB(10, 20, 2, 5),
                child: FutureBuilder<List<Pokemon>>(
                  future: pokemonLista,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Enquanto o Future estiver esperando, exibir um indicador de carregamento
                      return const Center(
                          child:
                              CircularProgressIndicator()); // No centro para o usuario ter impressão de loading
                    } else if (snapshot.hasError) {

                      return Column(
                        children: [
                          const Center(
                            child: Text('Erro ao carregar pokemons'),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () async {
                                //await pokemonLista;
                                pokemonLista = PokedexService()
                                    .buscandoDadosDosPokemons(contador = 0);
                                setState(() {});
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  const Center(
                                      child:
                                        CircularProgressIndicator()); // No centro para o usuario ter impressão de loading
                                }
                              },
                              child: const Text(
                                "Clique aqui para carregar dados novamente",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      );
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "#${pokemon.id}",
                                      textAlign: TextAlign.end,
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                                Image.network(
                                  width: 60,
                                  pokemon.imageUrl,
                                ),
                                Container(
                                  color: Colors.blue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: Colors.blue,
                                        child: Text(
                                          pokemon.name,
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                              color: Colors
                                                  .white), // Define a cor do texto como branca
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FloatingActionButton(
                    onPressed: () async {
                      print("passei aqui");
                      carregarMaisPokemons();
                      print("passei aqui");
                      setState(() {
                        print("passei aqui");
                        carregarMaisPokemons();
                        print("passei aqui");
                      });
                    },
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_downward_outlined,
                        color: Color.fromRGBO(236, 3, 68, 1),
                      ),
                      onPressed: () async {
                        await carregarMaisPokemons();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
