class Pokemon {
  int? id;
  String? num;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;

  Pokemon(
      {this.id, this.num, this.name, this.img, this.type, this.height, this.weight});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      num: json['num'],
      name: json['name'],
      img: json['img'],
      type: List<String>.from(json['type'].map((x) => x)),
      height: json['height'],
      weight: json['weight'],
    );
  }
}