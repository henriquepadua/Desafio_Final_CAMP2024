import 'package:desafio_final_camp2024/controllers/pokedex__controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pokedex extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  TextEditingController pokemonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                          padding: const EdgeInsets.fromLTRB( 0,0,50,0),
                          child: Image.asset("assets/heart.png")),
                    ],
                  ),

                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
