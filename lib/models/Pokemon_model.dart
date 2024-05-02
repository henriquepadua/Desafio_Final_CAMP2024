import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pokemon {
  final String name;
  final int id;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
  });
}