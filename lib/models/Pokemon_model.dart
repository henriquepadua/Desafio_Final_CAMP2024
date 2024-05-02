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

// class Pokemon {
//   final String name;
//   final String imageUrl;

//   Pokemon({required this.name, required this.imageUrl});

//   factory Pokemon.fromJson(Map<String, dynamic> json) {
//     return Pokemon(
//       name: json['name'],
//       imageUrl: json['img'],
//     );
//   }
// }