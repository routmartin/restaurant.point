import 'dart:convert';

class Table {
  Table({
    this.tableId,
    this.tableName,
    this.tableStatus,
    this.tableImage,
    this.groupMerge,
    this.saleStatus,
    this.checkinDuration,
    this.saleMasterId,
  });

  int tableId;
  String tableName;
  String tableStatus;
  var tableImage;
  String groupMerge;
  String saleStatus;
  String checkinDuration;
  int saleMasterId;

  factory Table.fromRawJson(String str) => Table.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        tableId: json["table_id"],
        tableName: json["table_name"],
        tableStatus: json["table_status"],
        tableImage: json["table_image_status"],
        groupMerge: json["group_merge"],
        saleStatus: json["sale_status"],
        checkinDuration: json["checkin_duration"],
        saleMasterId: json["sale_master_id"],
      );

  Map<String, dynamic> toJson() => {
        "table_id": tableId,
        "table_name": tableName,
        "table_status": tableStatus,
        "table_image_status": tableImage,
        "group_merge": groupMerge,
        "sale_status": saleStatus,
        "checkin_duration": checkinDuration,
        "sale_master_id": saleMasterId,
      };
}
