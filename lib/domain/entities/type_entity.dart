class TypeEntity {
  int? id;
  String? name;
  List<String>? noDamageTo;
  List<String>? halfDamageTo;
  List<String>? doubleDamageTo;
  List<String>? noDamageFrom;
  List<String>? halfDamageFrom;
  List<String>? doubleDamageFrom;

  TypeEntity({
    this.id,
    this.name,
    this.noDamageTo,
    this.halfDamageTo,
    this.doubleDamageTo,
    this.noDamageFrom,
    this.halfDamageFrom,
    this.doubleDamageFrom,
  });

  TypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'].toInt();
    name = json['name'].toString();
    noDamageTo = json["damage_relations"]['no_damage_to'].toList();
    halfDamageTo = json["damage_relations"]['half_damage_to'].toList();
    doubleDamageTo = json["damage_relations"]['double_damage_to'].toList();
    noDamageFrom = json["damage_relations"]['no_damage_from'].toList();
    halfDamageFrom = json["damage_relations"]['half_damage_from'].toList();
    doubleDamageFrom = json["damage_relations"]['double_damage_from'].toList();
  }
}
