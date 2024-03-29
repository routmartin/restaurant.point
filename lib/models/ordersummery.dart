import 'dart:convert';

class Ordersummery {
  Ordersummery({
    this.itemDetailId,
    this.saleDetailId,
    this.name,
    this.qty,
    this.unitPrice,
    this.disPrice,
    this.disPercent,
    this.amount,
    this.pendingPrint,
    this.notes,
  });

  int itemDetailId;
  int saleDetailId;
  String name;
  String qty;
  String unitPrice;
  String disPrice;
  String disPercent;
  String amount;
  String pendingPrint;
  List<AddNote> notes;

  factory Ordersummery.fromRawJson(String str) =>
      Ordersummery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ordersummery.fromJson(Map<String, dynamic> json) => Ordersummery(
        itemDetailId: json["item_detail_id"],
        saleDetailId: json["sale_detail_id"],
        name: json["name"],
        qty: json["qty"],
        unitPrice: json["unit_price"],
        disPrice: json["dis_price"],
        disPercent: json["dis_percent"],
        amount: json["amount"],
        pendingPrint: json["pending_print"],
        notes:
            List<AddNote>.from(json["notes"].map((x) => AddNote.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_detail_id": itemDetailId,
        "sale_detail_id": saleDetailId,
        "name": name,
        "qty": qty,
        "unit_price": unitPrice,
        "dis_price": disPrice,
        "dis_percent": disPercent,
        "amount": amount,
        "pending_print": pendingPrint,
        "notes": List<dynamic>.from(
          notes.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class AddNote {
  AddNote({
    this.noteId,
    this.noteName,
    this.notePrice,
    this.pendingPrint,
  });

  int noteId;
  String noteName;
  String notePrice;
  String pendingPrint;

  factory AddNote.fromRawJson(String str) => AddNote.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddNote.fromJson(Map<String, dynamic> json) => AddNote(
        noteId: json["note_id"],
        noteName: json["note_name"],
        notePrice: json["note_price"],
        pendingPrint: json["pending_print"],
      );

  Map<String, dynamic> toJson() => {
        "note_id": noteId,
        "note_name": noteName,
        "note_price": notePrice,
        "pending_print": pendingPrint,
      };
}
