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

  Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.primeiroValorCor,
    required this.segundoValorCor,
    required this.terceiroValorCor,
    required this.quartoValorCor,
  });
}
