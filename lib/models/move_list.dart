import 'dart:convert';

class MoveList {
  MoveList({
    this.floorId,
    this.floorName,
    this.tables,
  });

  int floorId;
  String floorName;
  List<TableMove> tables;

  factory MoveList.fromRawJson(String str) =>
      MoveList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MoveList.fromJson(Map<String, dynamic> json) => MoveList(
        floorId: json["floor_id"],
        floorName: json["floor_name"],
        tables: List<TableMove>.from(
            json["tables"].map((x) => TableMove.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "floor_id": floorId,
        "floor_name": floorName,
        "tables": List<dynamic>.from(tables.map((x) => x.toJson())),
      };
}

class TableMove {
  TableMove({
    this.tableId,
    this.tableName,
    this.tableImage,
  });

  int tableId;
  String tableName;
  String tableImage;

  factory TableMove.fromRawJson(String str) =>
      TableMove.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TableMove.fromJson(Map<String, dynamic> json) => TableMove(
        tableId: json["table_id"],
        tableName: json["table_name"],
        tableImage: json["table_image"],
      );

  Map<String, dynamic> toJson() => {
        "table_id": tableId,
        "table_name": tableName,
        "table_image": tableImage,
      };
}
