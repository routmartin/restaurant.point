import 'dart:convert';

class Note {
  Note({
    this.noteId,
    this.noteName,
    this.notePrice,
    this.pendingPrint,
  });

  int noteId;
  String noteName;
  String notePrice;
  String pendingPrint;

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
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
