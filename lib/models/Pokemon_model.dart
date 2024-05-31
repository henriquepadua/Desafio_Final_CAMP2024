import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pokemon {
  final String name;
  int id;
  final String imageUrl;
  final int primeiroValorCor;
  final int segundoValorCor;
  final int terceiroValorCor;
  final double quartoValorCor;
  final String moves;
  final double weight;
  final double height;
  final int hp;
  final int atk;
  final int def;
  final int satk;
  final int sdef;
  final int spo;

  Pokemon(
      {required this.name,
      required this.id,
      required this.imageUrl,
      required this.primeiroValorCor,
      required this.segundoValorCor,
      required this.terceiroValorCor,
      required this.quartoValorCor,
      required this.moves,
      required this.height,
      required this.weight,
      required this.atk,
      required this.def,
      required this.hp,
      required this.satk,
      required this.sdef,
      required this.spo
      });
}
