import 'dart:convert';

import 'package:pointrestaurant/models/Item.dart';

class Menu {
  Menu({
    this.typeId,
    this.typeName,
    this.photo,
    this.items,
  });

  int typeId;
  String typeName;
  String photo;
  List<Item> items;

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        typeId: json["type_id"],
        typeName: json["type_name"],
        photo: json["photo"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "type_name": typeName,
        "photo": photo,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
