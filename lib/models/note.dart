import 'dart:convert';

class Note {
  Note({
    this.noteId,
    this.noteName,
    this.notePrice,
    this.image,
  });

  int noteId;
  String noteName;
  String notePrice;
  String image;

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteId: json["id"],
        noteName: json["name"],
        notePrice: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": noteId,
        "name": noteName,
        "price": notePrice,
        "image": image,
      };
}
