import 'dart:convert';

import 'package:pointrestaurant/models/table.dart';

class Floor {
  Floor({
    this.floorId,
    this.floorName,
    this.tables,
  });

  int floorId;
  String floorName;
  List<Table> tables;

  factory Floor.fromRawJson(String str) => Floor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
        floorId: json["floor_id"],
        floorName: json["floor_name"],
        tables: List<Table>.from(json["tables"].map((x) => Table.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "floor_id": floorId,
        "floor_name": floorName,
        "tables": List<dynamic>.from(tables.map((x) => x.toJson())),
      };
}
