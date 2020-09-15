// To parse this JSON data, do
//
//     final listSaleData = listSaleDataFromJson(jsonString);

import 'dart:convert';

class ListSaleData {
  ListSaleData({
    this.id,
    this.invoice,
    this.totalDisItem,
    this.subTotal,
    this.discountInvPercentage,
    this.discountInvDollars,
    this.grandTotal,
    this.status,
  });

  int id;
  String invoice;
  double totalDisItem;
  String subTotal;
  String discountInvPercentage;
  String discountInvDollars;
  String grandTotal;
  String status;

  factory ListSaleData.fromRawJson(String str) =>
      ListSaleData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListSaleData.fromJson(Map<String, dynamic> json) => ListSaleData(
        id: json["id"],
        invoice: json["invoice"],
        totalDisItem: json["total_disItem"],
        subTotal: json["sub_total"],
        discountInvPercentage: json["discount_inv_percentage"],
        discountInvDollars: json["discount_inv_dollars"],
        grandTotal: json["grand_total"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "total_disItem": totalDisItem,
        "sub_total": subTotal,
        "discount_inv_percentage": discountInvPercentage,
        "discount_inv_dollars": discountInvDollars,
        "grand_total": grandTotal,
        "status": status,
      };
}
