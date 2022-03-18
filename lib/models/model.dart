
import 'dart:convert';

List<ModelCard> imagesFromJson(String str) => List<ModelCard>.from(json.decode(str).map((x) => ModelCard.fromJson(x)));

String imagesToJson(List<ModelCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCard{

  late String name;
  late String phoneNumber;
  late String relationShip;

  ModelCard(this.name, this.phoneNumber, this.relationShip);

  ModelCard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    relationShip = json['relationShip'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phoneNumber'] = phoneNumber;
    map['relationShip'] = relationShip;
    return map;
  }

}