import 'package:Desafio_Final_CAMP2024/models/Pokemon_model.dart';
import 'package:flutter/material.dart';

class PerfiPokemon extends StatefulWidget {
  final Pokemon
      pokemonLista; // Assuming the type of pokemonLista is dynamic for this example

  const PerfiPokemon({Key? key, required this.pokemonLista}) : super(key: key);

  @override
  _PerfiPokemonState createState() => _PerfiPokemonState();
}

class _PerfiPokemonState extends State<PerfiPokemon> {
  Pokemon? tranferindoPokemon;

  @override
  void initState() {
    super.initState();
    tranferindoPokemon = widget.pokemonLista;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(
            tranferindoPokemon!.primeiroValorCor,
            tranferindoPokemon!.segundoValorCor,
            tranferindoPokemon!.terceiroValorCor,
            tranferindoPokemon!.quartoValorCor,
          ),
          title: Row(
            children: [
              Text("${tranferindoPokemon?.name}"),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 100)),
              Text("#${widget.pokemonLista.id}"),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(
          tranferindoPokemon!.primeiroValorCor,
          tranferindoPokemon!.segundoValorCor,
          tranferindoPokemon!.terceiroValorCor,
          tranferindoPokemon!.quartoValorCor,
        ),
        body: Container(
          width: 600,
          height: 500,
          child: Dialog(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network("${tranferindoPokemon?.imageUrl}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/Frame.png"),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text(
                    "${tranferindoPokemon?.weight} kg",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                  Image.asset("assets/Frame1.png"),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text("${tranferindoPokemon?.height} m",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text(
                    "${tranferindoPokemon?.moves}",
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text("Weight"),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12)),
                  Text("Height"),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                  Text("Moves"),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              const Row(children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                Text("data")
              ],),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              const Row(children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                Text("Base Stats",style: TextStyle(color: Color.fromRGBO(116, 203, 72, 1)),)
              ],),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("HP"),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text("${tranferindoPokemon?.hp}"),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("ATK"),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text("${tranferindoPokemon?.atk}"),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("DEF"),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text("${tranferindoPokemon?.def}"),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("SATK"),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text("${tranferindoPokemon?.satk}"),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("SDEF"),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text("${tranferindoPokemon?.sdef}"),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
                    Text("SPD"),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                    Text("${tranferindoPokemon?.spo}"),
                  ],
                ),
              ],)
            ]),
          ),
        ),
      ),
    );
  }
}
