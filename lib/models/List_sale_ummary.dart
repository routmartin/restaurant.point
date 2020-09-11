import 'dart:convert';

class ListSaleSummary {
  ListSaleSummary({
    this.id,
    this.invoice,
    this.grandTotal,
    this.status,
  });

  int id;
  String invoice;
  String grandTotal;
  String status;

  factory ListSaleSummary.fromRawJson(String str) =>
      ListSaleSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListSaleSummary.fromJson(Map<String, dynamic> json) =>
      ListSaleSummary(
        id: json["id"],
        invoice: json["invoice"],
        grandTotal: json["grand_total"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "grand_total": grandTotal,
        "status": status,
      };
}
