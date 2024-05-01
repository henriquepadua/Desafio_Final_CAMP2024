class Pokemon {
  int? id;
  String? num;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  int? candyCount;
  String? egg;
  double? spawnChance;
  double? avgSpawns;
  String? spawnTime;
  List<double>? multipliers;
  List<String>? weaknesses;

  Pokemon(
      {this.id,
      this.num,
      this.name,
      this.img,
      this.type,
      this.height,
      this.weight,
      this.candy,
      this.candyCount,
      this.egg,
      this.spawnChance,
      this.avgSpawns,
      this.spawnTime,
      this.multipliers,
      this.weaknesses,});

  Pokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    img = json['img'];
    type = json['type'].cast<String>();
    height = json['height'];
    weight = json['weight'];
    candy = json['candy'];
    candyCount = json['candy_count'];
    egg = json['egg'];
    spawnChance = json['spawn_chance'];
    avgSpawns = json['avg_spawns'];
    spawnTime = json['spawn_time'];
    multipliers = json['multipliers'].cast<double>();
    weaknesses = json['weaknesses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['name'] = this.name;
    data['img'] = this.img;
    data['type'] = this.type;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['candy'] = this.candy;
    data['candy_count'] = this.candyCount;
    data['egg'] = this.egg;
    data['spawn_chance'] = this.spawnChance;
    data['avg_spawns'] = this.avgSpawns;
    data['spawn_time'] = this.spawnTime;
    data['multipliers'] = this.multipliers;
    data['weaknesses'] = this.weaknesses;
    return data;
  }
}
